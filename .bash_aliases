alias vimaliases='vim ~/.bash_aliases; source ~/.bash_aliases'

alias cdg='cd ~/git/; ll'
alias cdgp='cd ~/git/powercurve; echo "cd $(pwd)"'
alias cdgpst='cdgp; git st'

alias chrome='/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe'

alias diff='~/opt/colordiff/colordiff.pl -u'

alias errcho='>&2 echo'

alias gitk='gitk --since=2018-06-01'
alias gitkall='gitk --since=2010-01-01 &'
alias gitkd='gitk --all &'
alias gitbs='git branch --sort=-committerdate -vv'
alias gitfap='git fetch -n --all --prune'
alias gitmerged='git branch --merged origin/master | grep -Pv "\*|master" | xargs -n 1 echo git branch -d'
alias gitdnd='git diff --name-only origin/develop...'
alias gitdndc='gitdnd | wc -l'
alias gittouched='(git diff --name-only 2>/dev/null; git diff --name-only --cached 2>/dev/null; git diff --name-only origin/develop...) 2>/dev/null'
alias git-commit-separately='for NAME in $(git diff --name-only); do echo $NAME; git add $NAME; git commit -m "$NAME"; done'
alias grep='grep --color'
alias grok='git ls-files | grep'

alias jar='/c/Program\ Files/Java/jdk1.8.0_172/bin/jar'

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

alias serialverusage='echo serialver -classpath /c/powercurve/ANA-106819/clients/sds/idap/modules/ext/com.experian.eda.cap.framework/Framework_Common_Interfaces-1.16.3-SNAPSHOT.jar:/c/Users/C22407A/.m2/repository/org/slf4j/slf4j-api/1.7.25/slf4j-api-1.7.25.jar com.experian.eda.framework.common.business.interfaces.strategy.AbstractSegmentationComponent'

alias snapshots-remove-from-feature-branch='sed -i s/-SNAPSHOT//g $(git diff origin/develop... --name-only | grep "pom\.xml$"); git diff'

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

grep-poms() {
    grep -IRHn $* $(git ls-files | grep 'pom.xml')
}

diff-branches-from() {
    MERGE_BASE=origin/develop
    diff -u <(git diff $MERGE_BASE...$1) <(git diff $MERGE_BASE...$2)
}
