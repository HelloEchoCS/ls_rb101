| Line | Action | Object | Side Effect | Return Value | Is Return Value Used? |
| ---- | ------ | ------ | ----------- | ------------ | --------------------- |
| 1 | method call `map` | The outer array | None | New array `[1, 3]` | No |
| 1-4 | block execution | Each sub-array | None | First element of each sub-array | Yes, by `map` for transformation |
| 2 | method call `first` | Each sub-array | None | Element at index0 of sub-array | Yes, by `puts` |
| 2 | method call `puts` | Element at index0 of each sub-array | Print a string representation an Integer | `nil` | No |
| 3 | method call `first` | Each sub-array | None | Element at index0 of sub-array | Yes, used to determine the return value of the block |