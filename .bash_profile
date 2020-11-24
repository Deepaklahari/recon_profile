export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH


dirsearch() {
python3 ~/tools/dirsearch/dirsearch.py -u $1 -e $2
}

sublister() {
python ~/tools/Sublist3r/sublist3r.py -d $1 -o sublister.txt
}

assetfinder() {
/root/go/bin/assetfinder --subs-only $1 > assets.txt
}

subfinder() {
/root/go/bin/subfinder -d $1 -o subfinder.txt -recursive
}


waybackurls() {
/root/go/bin/waybackurls
}

hakrawler() {
/root/go/bin/hakrawler
}

httprobe(){
cat $1| /root/go/bin/httprobe > probe.txt
}



recon() {
python ~/tools/Sublist3r/sublist3r.py -d $1 -o sublister.txt
/root/go/bin/assetfinder --subs-only $1 > assets.txt
/root/go/bin/subfinder -d $1 -all -recursive -silent -o subfinder.txt
/root/tools/findomain-linux --target $1 --unique-output findomains.txt
cat *.txt | sort -u > subdomains.txt
cat subdomains.txt | httpx -silent -follow-redirects   > final.txt
echo "Total Subdomains Found" 
wc -l final.txt
nuclei -l final.txt -t /root/nuclei-templates -o nuclei.txt
}

findomain() {
/root/tools/findomain-linux --target $1 --unique-output findomains.txt
}

jsfile() {
cat final.txt | gau  | grep ".js$" | uniq | sort | subjs > js.txt
cat js.txt | hakcheckurl | grep "200" | sort -u >jsfinal.txt
}

EyeWitness() {
python3 ~/tools/EyeWitness/Python/EyeWitness.py
}

sqli() {
echo $1 | gau | gf sqli > sqli.txt
}

fuzz() {
ffuf -w $1 -u $2 -r -recursion -c -sf 
}

nucleiscan() {
nuclei -l $1 -t /root/nuclei-templates -o nuclei.txt
}

nucleiscan() {
nuclei -l $1 -t /root/nuclei-templates -o nuclei.txt
}
