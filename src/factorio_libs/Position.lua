local Position = {}

function Position.equals(a, b)
    return (a.x or a[1]) == (b.x or b[1]) and (a.y or a[2]) == (b.y or b[2])
end

function Position.add(a, b)
    return {(a.x or a[1]) + (b.x or b[1]), (a.y or a[2]) + (b.y or b[2])}
end

function Position.subtract(a, b)
    return {(a.x or a[1]) - (b.x or b[1]), (a.y or a[2]) - (b.y or b[2])}
end

Position.eq = Position.equals
Position.sub = Position.subtract

function Position.copy(pos)
    return {pos.x or pos[1], pos.y or pos[2]}
end

function Position.length(pos)
    return math.sqrt((pos.x or pos[1])^2 + (pos.y or pos[2])^2)
end

function Position.distance(a, b)
    return Position.length(Position.subtract(a, b))
end

return Position
