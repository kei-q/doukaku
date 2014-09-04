#! /usr/local/bin/zsh

git commit -am 'save' 1>/dev/null

DATE=`date +"%Y%m%d_%H%M%S"`

SPEC_FILE=spec-$DATE.txt
WC_FILE=wc-$DATE.txt
CHECK_FILE=check-$DATE.txt

LOG_DIR="log"

SPEC_PATH=$LOG_DIR/$SPEC_FILE
WC_PATH=$LOG_DIR/$WC_FILE
CHECK_PATH=$LOG_DIR/$CHECK_FILE

if [ ! -d log ]; then
  mkdir log
fi

/usr/local/bin/runghc Spec.hs &> $SPEC_PATH
cp $SPEC_PATH spec.txt

/Users/keqh/.cabal/bin/ghc-mod check -g -fno-warn-unused-imports Main.hs 2>&1 > /tmp/check.txt
cat /tmp/check.txt | /Users/keqh/.rbenv/shims/ruby -pe '$_.gsub!(/\x0/, "\n")' > $CHECK_PATH
cp $CHECK_PATH check.txt

wc Main.hs > $WC_PATH
