alias ls='ls -A'
alias ll='ls -l'

alias vimaliases='vim ~/.bash_aliases; source ~/.bash_aliases'

alias upper='tr [:lower:] [:upper:]'

alias dt='date +%Y%m%d'
alias tm='date +%H%M'

#alias apollo-remote-branches-without-commits='for BRANCH in $(git branch -a | grep -iPo 'origin/apollo/.*'); do if [[ ! $(git --no-pager log origin/develop..$BRANCH) ]]; then echo $BRANCH; fi; done'
alias apollo-remote-branches-merged='for BRANCH in $(git branch -a --merged origin/develop | grep -iPo "origin/apollo/.*"); do ANA=$(echo $BRANCH | grep -iPo "ANA-\d*"); if [[ $( git --no-pager log --no-merges $BRANCH -n 9 | grep $ANA ) ]]; then echo $BRANCH; fi; done'
alias apollo-remote-branches-unused='for BRANCH in $(git branch -a --merged origin/develop | grep -iPo "origin/apollo/.*"); do ANA=$(echo $BRANCH | grep -iPo "ANA-\d*"); if [[ ! $( git --no-pager log --no-merges $BRANCH -n 9 | grep $ANA ) ]]; then echo $BRANCH; fi; done'
alias apollo-remote-branches-unmerged='for BRANCH in $(git branch -a --no-merged origin/develop | grep -iPo "origin/apollo/.*"); do echo $BRANCH; done'
#alias apollo-remote-branches-inactive='for BRANCH in $(git branch -a --no-merged origin/develop | grep -iPo "origin/apollo/.*"); do FILTER_OLDER_THAN_A_MONTH; echo $BRANCH; done'
#alias apollo-remote-branches-active='for BRANCH in $(git branch -a --no-merged origin/develop | grep -iPo "origin/apollo/.*"); do FILTER_YOUNGER_THAN_A_MONTH; echo $BRANCH; done'

#alias ana='git log -n 4 --oneline | grep -Po "ANA-\d*" | head -n 1'
#alias ana='git branch | grep "*" | cut -d" " -f2  | grep -Po "ANA-\d*"'
#alias ana='git rev-parse --abbrev-ref HEAD | grep -Po "ANA-\d*"'
alias extract-ana='grep -iPo "ANA-\d*"'
#alias ana='git rev-parse --abbrev-ref HEAD | extract-ana'
alias git-branch-current='git rev-parse --abbrev-ref HEAD'
alias ana='git-branch-current | extract-ana'

#alias git-log-unmerged='BRANCH=$(git rev-parse --abbrev-ref HEAD); git log $BRANCH --oneline $(git merge-base origin/develop $BRANCH)..'
alias git-log-unmerged='BRANCH=$(git rev-parse --abbrev-ref HEAD); git --no-pager log $BRANCH --pretty=format:"%h%x09%aN%x09%aI%x09%s" $(git merge-base origin/develop $BRANCH)..'
alias unixdate='xargs -I {} date -d {} +%s'
#TODO combine git-log-unmerged | unixdate with if [ $todate -ge $cond ]; where if [ $todate -ge $cond ]; if [ $todate -ge $cond ];

alias git-log-this-branch-only='git log origin/develop..'
alias git-diff-this-branch-only='git diff origin/develop...'

alias cdg='cd ~/git/; ll'
alias cdgp='cd ~/git/powercurve; echo "cd $(pwd)"'
alias cdgpst='cdgp; git st'

alias chrome='/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe'

alias debug-dsv='/c/powercurve/ANA-99355/dsv-2.8.11.19/bin/dsv.exe -J-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1375 &'
alias debug-sds='/c/powercurve/2232/clients/sds/bin/sds.exe --console suppress -J-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1395 -J-XX:MaxMetaspaceSize=1g -J-DANA-105720=true &'

alias diff='~/opt/colordiff/colordiff.pl -u'
alias diff-backup-develop='diff -u <(git diff origin/develop...backup) <(git diff origin/develop...)'

alias grep-aliases='alias | grep'

alias errcho='>&2 echo'

alias git-remote-branches-to-delete='git branch -a --merged remotes/origin/develop | grep -v "develop$" | grep -v "origin/master$" | grep -v HEAD | grep "remotes/origin/" | cut -d "/" -f 3- #| xargs -n 1 echo git push --delete origin'
alias git-backup-reup='git branch -D backup; git branch backup'
alias gitk='gitk --since=2018-08-01'
alias gitkall='gitk --since=2010-01-01 &'
alias gitkd='gitk --all &'
alias gitbs='git branch --sort=-committerdate -vv'
alias git-branch-apollo='git branch | grep -Po "apollo/[^ ]*"'
alias gitfap='git fetch -n --all --prune'
alias gitmerged='git branch --merged origin/master | grep -Pv "\*|master" | xargs -n 1 echo git branch -d'
alias gitdnd='git diff --name-only origin/develop...'
alias gitdndc='gitdnd | wc -l'
alias gittouched='(git diff --name-only 2>/dev/null; git diff --name-only --cached 2>/dev/null; git diff --name-only origin/develop...) 2>/dev/null'
alias git-commit-separately='for NAME in $(git diff --name-only); do echo $NAME; git add $NAME; git commit -m "$NAME"; done'
alias grep='grep --color'
alias grok='(cd $(git rev-parse --show-toplevel); git ls-files) | grep'
alias grok-apollo='cat ~/scratch/apollo/apollo-grok.txt | grep'
alias grok-apollo-java='grok-apollo "\.java$" | grep'
alias grok-apollo-pom='grok-apollo "pom.xml$" | grep'
alias grep-apollo-pom='grok-apollo "pom.xml$" | xargs grep'
alias grep-apollo-java='grok-apollo "\.java$" | xargs grep'
#alias grep-apollo-java='grok-apollo "\.java$" | xargs grep -IHn'
grep-apollo-java-freq() {
    grep-apollo-java $1 | cut -d':' -f1 | sort | uniq -c | sort -hr
}
winpath2unix() {
    echo "$1" | tr '\' '/' | sed 's/C:/\/c/g'
}
alias jar='/c/Program\ Files/Java/jdk1.8.0_172/bin/jar'

alias l='ls -1 --color'
alias less='less -Rf'

alias hsll='ll {assemblies/da/da-{hadoop,spark}-demo,assembly/resources/da/da-{hadoop,spark}-demo-{assembly-resources,jar}}/target'
alias hspv='grep -A 3 "</parent>" {assemblies/da/da-{hadoop,spark}-demo,assembly/resources/da/da-{hadoop,spark}-demo-{assembly-resources,jar}}/pom.xml'

pomid() {
    /c/Python27/python.exe -c "from xml.etree.ElementTree import ElementTree; print ElementTree(file=\"$1\").findtext(\"{http://maven.apache.org/POM/4.0.0}artifactId\")"
}
pomver() {
    /c/Python27/python.exe -c "from xml.etree.ElementTree import ElementTree; print ElementTree(file=\"$1\").findtext(\"{http://maven.apache.org/POM/4.0.0}version\")"
}
verincmic() {
    /c/Python27/python.exe -c"ver=\"$1\";spl=ver.split(\".\");mic=int(spl[-1]);print \".\".join(spl[:-1]+[str(mic+1)])"
}
pomverincmicsnap() {
    POM=$1
    VER=$(pomver $POM)
    VER2=$(verincmic $VER)
    sed -i -Ez "s/$ID<\/artifactId>([ \n]*)<version>$VER<\/version>/$ID<\/artifactId>\1<version>$VER2-SNAPSHOT<\/version>/" $POM
}
pomaddsnap() {
    POM=$1
    ID=$(pomid $POM)
    VER=$(pomver $POM)
#   sed    -Ez "s/$ID<\/artifactId>([ \n]*)<version>$VER<\/version>/$ID<\/artifactId>\1<version>$VER-SNAPSHOT<\/version>/" $POM | grep "</parent>" -A3
    sed -i -Ez "s/$ID<\/artifactId>([ \n]*)<version>$VER<\/version>/$ID<\/artifactId>\1<version>$VER-SNAPSHOT<\/version>/" $POM
}
affectedpoms() {
    git diff --name-only origin/develop... | grep -Po "(?<=^).*(?=src/)" | sort | uniq | sed 's/\/$/\/pom.xml/'
}
affectedpomsverincmicsnap() {
	for POM in $(affectedpoms | head -n 2); do pomverincmicsnap $POM; done
}

#slow#alias mvn-id-from-pom='mvn -q -Dexec.executable="echo" -Dexec.args=\$\{project.groupId\}\:\$\{project.artifactId\} --non-recursive org.codehaus.mojo:exec-maven-plugin:1.3.1:exec 2>/dev/null'

alias nppp='/c/Program\ Files/Notepad++/notepad++.exe'

alias python='winpty /c/Python27/python.exe'

alias visualvm='"/c/Program Files/Java/jdk1.8.0_162/bin/jvisualvm.exe"'

rcut() {
    rev | cut "$@" | rev
}

alias serialverusage='echo serialver -classpath /c/powercurve/ANA-106819/clients/sds/idap/modules/ext/com.experian.eda.cap.framework/Framework_Common_Interfaces-1.16.3-SNAPSHOT.jar:/c/Users/C22407A/.m2/repository/org/slf4j/slf4j-api/1.7.25/slf4j-api-1.7.25.jar com.experian.eda.framework.common.business.interfaces.strategy.AbstractSegmentationComponent'

alias snapshots-remove-from-feature-branch-and-diff='sed -i s/-SNAPSHOT//g $(git diff origin/develop... --name-only | grep "pom\.xml$"); git diff'
alias snapshots-remove-from-feature-branch-and-commit='sed -i s/-SNAPSHOT//g $(git diff origin/develop... --name-only | grep "pom\.xml$"); git add .; git commit -m "$(ana) Remove -SNAPSHOTs"; git show'

alias uniqc="uniq -c | sed 's/^[ ]*//;s/ /\t/'"


alias poms-bump-major-snapshot='mvn build-helper:parse-version versions:set -DnewVersion=\${parsedVersion.nextMajorVersion}.0.0-SNAPSHOT versions:commit'
alias poms-bump-minor-snapshot='mvn build-helper:parse-version versions:set -DnewVersion=\${parsedVersion.majorVersion}.\${parsedVersion.nextMinorVersion}.0-SNAPSHOT versions:commit'
alias poms-bump-micro-snapshot='mvn build-helper:parse-version versions:set -DnewVersion=\${parsedVersion.majorVersion}.\${parsedVersion.minorVersion}.\${parsedVersion.nextIncrementalVersion}-SNAPSHOT versions:commit'
alias poms-snapshot-remove='mvn build-helper:parse-version versions:set -DnewVersion=\${parsedVersion.majorVersion}.\${parsedVersion.minorVersion}.\${parsedVersion.incrementalVersion} versions:commit'
#mvn versions:set -DremoveSnapshot

# -pl com.experian.eda.cap.framework:Framework_Authentication_Business,com.experian.eda.cap.framework:Framework_SAE_Login_Service

upfind() {
    (while [[ $PWD != / ]]; do find "$PWD"/ -maxdepth 1 "$@"; cd ..; done)
}
#alias nearest-poms='upfind -type f -name pom.xml'
alias nearest-poms='(while [[ $PWD =~ "git/powercurve" && $PWD != "/c/Users/C22407A/git/powercurve" ]]; do find "$PWD"/ -maxdepth 1 -type f -name pom.xml; cd ..; done)'
alias nearest-pom='nearest-poms | head -n 1'
nearest-pom-to() {(cd ~/git/powercurve/; cd $(dirname $1); while [[ $PWD =~ "git/powercurve" && $PWD != "/c/Users/C22407A/git/powercurve" ]]; do find "$PWD"/ -maxdepth 1 -type f -name pom.xml; cd ..; done | head -n 1)}

alias which-pom-files='(for FILE in $(gittouched); do nearest-pom-to $FILE; done) | sort | uniq'
alias which-pom-ids='(for POM in $(which-pom-files); do cd $(dirname $POM); mvn-id-from-pom; done)'

poms-for-paths-matching() {
    git ls-files | grep $* | grep -o ".*/src" | sed s/src$/pom.xml/g | sort | uniq
}

poms-containing() {
    git ls-files "**/pom.xml" | xargs grep -IHn $* | cut -d':' -f1 | sort | uniq 
}

grep-poms() {
    grep -IRHn $* $(git ls-files "**/pom.xml")
}

diff-branches-from() {
    MERGE_BASE=origin/develop
    diff -u <(git diff $MERGE_BASE...$1) <(git diff $MERGE_BASE...$2)
}

alias untar-all='for TAR in $(ls *.tar); do mkdir $TAR.d; tar -xf $TAR -C $TAR.d; done'
alias unzip-all='for ZIP in $(ls *.zip); do unzip -q -d $ZIP.d $ZIP; done'

alias file-all-dirs='for DIR in $(ls -d *); do cd $DIR && (find . -type f -print0 | xargs -0 file >> ../$DIR.file) && cd ..; done'
