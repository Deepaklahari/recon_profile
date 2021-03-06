export GOROOT=/usr/local/go                                                                                                                                              
export GOPATH=$HOME/go                                                                                                                                                   
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH                                                                                                                                
                                                                                                                                                                         
                                                                                                                                                                         
dirsearch() {                                                                                                                                                            
python3 ~/tools/dirsearch/dirsearch.py -u $1 -w $2 -E                                                                                                                    
}                                                                                                                                                                        
adminfinder() {                                                                                                                                                          
python3 ~/tools/okadminfinder3/okadminfinder.py -u $1                                                                                                                    
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
# ffuf -w /home/rjlahari/wordlist/all.txt -u "https://FUZZ.$1/" -v | grep "| URL |" | awk '{print $4}' > fuzz.txt                                                        
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

gitdork() {
python3 /root/tools/GitDorker/GitDorker.py -tf /root/tools/GitDorker/tf/TOKENSFILE -org $1 -d /root/tools/GitDorker/Dorks/alldorksv2 -o gitdork
}

takeover() {
python3 /root/tools/takeover/takeover.py -l $1 -o takeover.txt -t 40 -v
}
