using JSON

function convertjson(sol, keys)
    output = Dict()
    for key in keys
        output[key] = sol[key]
    end
    
    json_data = Dict("sol" => output)
    json_str = JSON.json(json_data)

    filename = "output.json"
    open(filename, "w") do io
        println(io, json_str)
    end
end

# # 示例字典 sol 和 keys
# sol = Dict(
#     "a" => [1.0, 2.0, 3.0],
#     "b" => [4.0, 5.0, 6.0],
#     "c" => [7.0, 8.0, 9.0]
# )
# keys = ("a", "b", "c")

# f(sol, keys)