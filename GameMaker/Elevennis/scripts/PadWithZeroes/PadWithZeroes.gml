function PadWithZeroes(_value, _width)
{
    var s = string(_value);
    var missing = _width - string_length(s);
    if (missing > 0)
        s = string_repeat("0", missing) + s;
    return s;
}
