1 - клонируем репозиторий git clone https://github.com/pahartrahar228/flaskApp/tree/dev
2 - переходим в каталог сd flaskApp
3 - копируем файл сервиса flaskapp.service в /etc/systemd/system/flaskapp.service
cp flaskapp.service /etc/systemd/system/flaskapp.service
4 - перезапускаем демон добавляем в автозагрузку стартуем сервис и смотрим сосотояние 
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable flaskapp.service
sudo systemctl start flaskapp.service
sudo systemctl status flaskapp.service
5 - естанавливаем certbot
sudo apt install certbot и генерируем сертификаты
sudo certbot certonly --webroot -w ./certbot/www -d test-devops.vizorlabs.tech
6 - копируем сертификаты в папке с сервисом 
sudo cp -r /etc/letsencrypt/live flaskApp/certbot/conf/
sudo cp -r /etc/letsencrypt/archive flaskApp/certbot/conf/
sudo cp -r /etc/letsencrypt/renewal flaskApp/certbot/conf/
7 - выдаем права
sudo chown -R $USER:$USER flaskApp/certbot/conf/archive
sudo chown -R $USER:$USER flaskApp/certbot/conf/live
sudo chown -R $USER:$USER flaskApp/certbot/conf/renewal
8 - перезагружаем приложение 
sudo systemctl stop flaskapp.service
sudo systemctl start flaskapp.service
9 - разрешаем выполнение скриптов бекапа
sudo chown +x backup.sh
sudo chown +x restore.sh
10 - создаем бекап 
./backup.sh
11 - восстанавливаем из бекапа
./restore.sh
