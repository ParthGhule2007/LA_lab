#!/bin/bash
set -e

lab start files-review

ssh student@serverb 'bash -s' << 'EOF'
set -e

mkdir -p ~/Documents/project_plans
touch ~/Documents/project_plans/season{1,2}_project_plan.odf

touch ~/tv_season{1..2}_episode{1..6}.ogg
touch ~/mystery_chapter{1..8}.odf

mkdir -p ~/Videos/season{1,2}
cd ~/Videos
mv ~/tv_season1_episode*.ogg season1/
mv ~/tv_season2_episode*.ogg season2/

mkdir -p ~/Documents/my_bestseller/chapters
mkdir ~/Documents/my_bestseller/{editor,changes,vacation}

cd ~/Documents/my_bestseller/chapters
mv ~/mystery_chapter*.odf .
mv mystery_chapter{1..2}.odf ../editor/
mv mystery_chapter{7,8}.odf ../vacation/

cd ~/Videos/season2
cp tv_season2_episode1.ogg ~/Documents/my_bestseller/vacation/
cd ~/Documents/my_bestseller/vacation
ls
cd -
cp tv_season2_episode2.ogg ~/Documents/my_bestseller/vacation/
cd -

cd ~/Documents/my_bestseller
cp chapters/mystery_chapter[56].odf changes/

cd changes
cp mystery_chapter5.odf mystery_chapter5_$(date +%F).odf
cp mystery_chapter5.odf mystery_chapter5_$(date +%s).odf

rm -f *
cd ..
rmdir changes
rm -rf vacation

mkdir -p ~/Documents/backups
ln ~/Documents/project_plans/season2_project_plan.odf ~/Documents/backups/season2_project_plan.odf.back

cd ~
EOF

lab grade files-review
lab finish files-review
