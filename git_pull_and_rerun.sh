# .git_pull_and_rerun.sh 내용
# 기존장고 종료
docker exec python__2 pkill "gunicorn"

# 폴더에 깃에 있는 최신소스코드 가져오기
docker exec python__2 bash -c "cd /data/site_projects/python__2/src/ ; git pull origin master"

# 의존성 설치
docker exec python__2 bash -c "cd /data/site_projects/python__2/src/ ; pip install -r requirements.txt"

# 마이그레이트
docker exec python__2 bash -c "cd /data/site_projects/python__2/src/ ; python manage.py migrate"

# static collect 다시 수행
docker exec -it python__2 bash -c "cd /data/site_projects/python__2/src ; echo yes | python manage.py collectstatic"

# 장고를 운영모드로 실행
docker exec python__2 bash -c "cd /data/site_projects/python__2/src ; nohup gunicorn --bind=0.0.0.0:8000 base.wsgi &"