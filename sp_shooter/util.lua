util = {}

function util.available_path(pathlist)
    for _,path in ipairs(pathlist) do
        local f=io.open(name,"r")
        if f~=nil then
            io.close(f)
            return path
        end
    end

    return nil
end
