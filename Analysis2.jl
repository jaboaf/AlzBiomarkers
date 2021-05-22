using GRUtils
using Statistics
using StatsBase

ADNI = readlines("ADNIMERGE.csv")
ADNIVars = split(filter(!=('"'), merge[1]),",");
VARS = ["RID","AGE","PTGENDER","ABETA","TAU","PTAU","DX","Years_bl"]
VARSindex = findall(in(VARS),ADNIVars)

raw = map(ADNI[2:(end-1)]) do line
	split(filter(!=('"'), line),",")[VARSindex]
end

data = filter(x-> !("" in x), raw)
map(x->x[1],data)