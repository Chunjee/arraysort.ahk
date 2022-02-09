fn_sort2DArrayFast(byRef arr, key, Ascending := True)
{
	for index, obj in arr
		out .= obj[key] "+" index "|" ; "+" allows for sort to work with just the value
	; out will look like:   value+index|value+index|

	v := arr[arr.minIndex(), key]
	if v is number
		type := " N "
	StringTrimRight, out, out, 1 ; remove trailing |
	Sort, out, % "D| " type  (!Ascending ? " R" : " ")
	aStorage := []
	loop, parse, out, |
	   aStorage.insert(arr[SubStr(A_LoopField, InStr(A_LoopField, "+") + 1)])
	arr := aStorage
	return arr
}



Fn_Sort2DArray(Byref a, key, ascending := True)
{
	aStorage := []
	unsorted := True
	While unsorted
	{
		unsorted := False
		For index, in a
		{
			if (lastIndex = index)          ; This speeds it up (almost halves the time)
				break
			if (A_Index > 1) &&  (ascending
									? (a[prevIndex, key] > a[index, key])
									: (a[prevIndex, key] < a[index, key]))
			{
				; making this a single line expression saves ~20 ms on a 1000 index array
				aStorage := a[index]
				, a[index] := a[prevIndex]
				, a[prevIndex] := aStorage
				, unsorted := True
			}
			prevIndex := index
		}
		lastIndex := prevIndex ; previous maxIndex reached (i.e. position of the last moved highest/lowest number)
		; on each pass through the current highest number will be moved to 1 spot before 'lastIndex'
		; i.e. towards the right
		; As we know these values at the end are already the sorted
		; we can break, and don't have to worry about comparing them again
	}
}



Fn_ReverseArray(Byref a)
{
	aIndices := []
	for index, in a
		aIndices.insert(index)
	aStorage := []
	loop % aIndices.maxIndex()
	   aStorage.insert(a[aIndices[aIndices.maxIndex() - A_index + 1]])
	a := aStorage
	return aStorage
	; Note: If the object being passed resides within another object,
	; byRef wont affect it - so need to use the returned object e.g. aObject := reverse2DArray(aObject)
}



Fn_RandomiseArray(byref a)
{
	aIndicies := []
	for i, in a
		 aIndicies.insert(i)
	for index, in a
	{
		Random, i, 1, aIndicies.MaxIndex()
		storage := a[aIndicies[i]]
		, a[aIndicies[i]] := a[index]
		, a[index] := storage
	}
	return
}
