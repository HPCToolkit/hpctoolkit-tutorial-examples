CMD="sh make-scripts/submit.sh"
echo $CMD
$CMD

CMD="hpcstruct --gpucfg yes arborx-md-pc.m"
echo $CMD
$CMD

CMD="hpcprof -o arborx-md-pc.d arborx-md-pc.m"
echo $CMD
$CMD

CMD="hpcstruct --gpucfg no arborx-md.m"
echo $CMD
$CMD

CMD="hpcprof -o arborx-md.d arborx-md.m"
echo $CMD
$CMD

echo > ./run-done
