#
# - AWKLIB -
# Statistics functions
#-----------------------------------------------------------------
# 'min'		... Minimum (smallest) value in array
# 'max'		... Maximum (biggest) value in array
# 'average'	... is the average of a data set.
# 'mean'	... Same as average ...
# 		    mean function calls average and returns
# 'mode'	... is the most common number in a data set. 
# 'median'	... is the middle of the set of numbers.
# 'variance'	... is the squard deviation from the average value 
# 'stddev'      ... Standard deviation of the sample
#-----------------------------------------------------------------

# Return value of smallest value in array
function arr_min (arr,	a,min,idx) {
min=(2^PREC)
idx=0
	for (a in arr) {
		if (arr[a] < min) { min = arr[a]; idx=a } 
	}
	return arr[idx]
}

# Return value of biggest value in array
function arr_max (arr,	a,max,idx) {
max=(2^PREC)*(-1)
idx=0
	for (a in arr) {
		if (arr[a] > max) { max = arr[a]; idx=a } 
	}
	return arr[idx]
}

function average (arr,	a,sum) {
sum=0
	for ( a in arr) {
		sum += arr[a]
	}
	return sum/arr_size(arr)
}

#
# Calculate median of sample
#
function median (arr,	size,center,val) {
        asort(arr,tmp); 
	size=arr_size(tmp)
	
        if ( size%2 == 0 ) {
		center	= int(size/2)
		val	= (tmp[center] + tmp[center+1])/2
	} else {
		center	= int(size/2)+1
		val	= tmp[center]	
	} 
	delete tmp 
        return val
} 
 
function mean (arr) {
	return average(arr)
} 

# Return the most common VALUE(!)
function mode (arr,	a,many) { 
 
        for (a in arr) { 
                many[ arr[a] ]++  
        }

	return many[arr_max(many)]
} 
 
# Calculate variance of a sample
function variance(arr,	mean,sum_sq_diff,size,i) {
	mean=average(arr)
	sum_sq_diff = 0
	size = arr_size(arr)

	# Sum up differences
	for (i in arr) {
        	sum_sq_diff += (arr[i] - mean) ^ 2
    	}

	return sum_sq_diff / size
}

# Calculate standard deviation (uses variance)
function stddev(arr) {
    return sqrt(variance(arr))
}

