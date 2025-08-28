

```sh
python3 -m debugpy --listen 5678 --wait-for-client \
    /usr/local/lib/python3.9/site-packages/diff_cover/diff_cover_tool.py \
    scm-main/target/site/jacoco/jacoco.xml \
    --compare-branch=origin/master \
    --src-roots=scm-main/src/main/java/
```
