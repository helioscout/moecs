module std::collections::map { Key, Value };

macro HashMap.@each_ref(map; @body(key, value))
{
	map.@each_entry(; Entry* entry)
	{
		@body(entry.key, &entry.value);
	};
}
