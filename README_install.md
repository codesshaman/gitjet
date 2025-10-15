+ [English](https://github.com/codesshaman/gitjet/#English "English")
+ [Русский](https://github.com/codesshaman/gitjet/#Russian "Русский")

### English

### Description

This script automatically creates the configuration.git and uploads the first commit to the remote repository.

The settings for the name of the first branch and commit are in the gitjet script.

For the script to work, you need to configure the key using the script `keygen_en.sh `, the settings are described below.

# Usage

### Step 1: Clone repo

```
git clone https://github.com/codesshaman/gitjet.git
```

```
cd gitjet
```

### Step 2: Generate key

Open ``keygen_en.sh`` in text editor and change credentials to your github nickname and email.

Generate key:

```
./keygen_en.sh
```

### Installing:

```
cp gitjet_en gitjet
```

```
chmod a+x gitjet
```

```
sudo cp gitjet /usr/local/bin
```

### Command for launch:

```
gitjet
```

### Russian

### Описание

Данный скрипт автоматически создаёт конфигурацию .git и заливает первый коммит в удалённый репозиторий.

Настройки имени первой ветки и коммита находятся в скрипте gitjet.

Для работы скрипта необходимо настроить ключ скриптом ``keygen_en.sh``, настройки описаны ниже.

# Использование

### Установка:

```
git clone https://github.com/codesshaman/gitjet.git
```

``cd gitjet``

```
rm gitjet && mv gitjet_rus gitjet && chmod a+x gitjet
```

``sudo cp gitjet /usr/local/bin``

### Команда для запуска:

``gitjet``

### Команда для инициализации репозитория:

(выполнять из папки, созданной для репозитория)

``gitjet https://github.com/<user>/<repo>.git``
