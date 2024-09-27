local Job = require('plenary.job')
local Path = require('plenary.path')
local notification_queue = {}
local cache_timeout = 24 * 60 * 60
local M = {}

local function get_cache_dir()
    local cache_dir = vim.fn.stdpath('cache')
    return Path:new(cache_dir, 'octostats-cache')
end

local function get_cache_file_path(cache_key)
    local cache_dir = get_cache_dir()
    return cache_dir:joinpath(cache_key .. '.json')
end

local cache_dir = get_cache_dir()
cache_dir:mkdir({ parents = true, exists_ok = true })

local function read_cache_file(cache_file)
    if cache_file:exists() then
        local content = cache_file:read()
        local cache_data = M.safe_json_decode(content)
        if cache_data and cache_data.time and cache_data.data then
            return cache_data
        end
    end
    return nil
end

local function write_cache_file(cache_file, data)
    local cache_data = {
        time = os.time(),
        data = data,
    }
    cache_file:write(vim.json.encode(cache_data), 'w')
end

M.queue_notification = function(message, level)
    table.insert(notification_queue, { message = message, level = level })
end

M.show_notification = function(message, level)
    vim.notify(message, level, {
        title = 'Octostats',
        timeout = 5000,
    })
end

M.process_notification_queue = function()
    vim.schedule(function()
        while #notification_queue > 0 do
            local notification = table.remove(notification_queue, 1)
            M.show_notification(notification.message, notification.level)
        end
    end)
end

M.async_execute = function(command, callback)
    Job:new({
        command = vim.fn.has('win32') == 1 and 'cmd' or 'sh',
        args = vim.fn.has('win32') == 1 and { '/c', command } or { '-c', command },
        on_exit = function(j, return_val)
            local result = table.concat(j:result(), '\n')
            if return_val ~= 0 then
                M.queue_notification('Error executing command: ' .. command, vim.log.levels.ERROR)
                M.process_notification_queue()
                return
            end
            callback(result)
        end,
    }):start()
end

M.safe_json_decode = function(str)
    local success, result = pcall(vim.json.decode, str)
    if success then
        return result
    else
        M.queue_notification('Failed to parse JSON: ' .. result, vim.log.levels.ERROR)
        return nil
    end
end

M.get_data_with_cache = function(cache_key, command, callback)
    local cache_file = get_cache_file_path(cache_key)
    local cache_data = read_cache_file(cache_file)

    local current_time = os.time()

    if cache_data and (current_time - cache_data.time) < cache_timeout then
        callback(cache_data.data)
        return
    end

    M.async_execute(command, function(result)
        local data = M.safe_json_decode(result)
        if data then
            write_cache_file(cache_file, data)
            callback(data)
        end
    end)
end

return M
