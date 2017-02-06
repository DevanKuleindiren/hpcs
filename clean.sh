read -p "Are you sure you want to delete log files? (Remember to save the perplexity logs from training!) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	rm *.out
	rm *.log
	rm *.err
fi
