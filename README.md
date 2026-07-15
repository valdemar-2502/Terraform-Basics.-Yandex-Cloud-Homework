# Домашнее задание к занятию «Основы Terraform. Yandex Cloud» - Kadancev Vladimir

### Цели задания

1. Создать свои ресурсы в облаке Yandex Cloud с помощью Terraform.
2. Освоить работу с переменными Terraform.


### Чек-лист готовности к домашнему заданию

1. Зарегистрирован аккаунт в Yandex Cloud. Использован промокод на грант.
2. Установлен инструмент Yandex CLI.
3. Исходный код для выполнения задания расположен в директории [**02/src**](https://github.com/netology-code/ter-homeworks/tree/main/02/src).


### Задание 0

1. Ознакомьтесь с [документацией к security-groups в Yandex Cloud](https://cloud.yandex.ru/docs/vpc/concepts/security-groups?from=int-console-help-center-or-nav). 
Этот функционал понадобится к следующей лекции.

------
### Внимание!! Обязательно предоставляем на проверку получившийся код в виде ссылки на ваш github-репозиторий!
------

### Задание 1
В качестве ответа всегда полностью прикладывайте ваш terraform-код в git.
Убедитесь что ваша версия **Terraform** ~>1.12.0

1. Изучите проект. В файле variables.tf объявлены переменные для Yandex provider.
2. Создайте сервисный аккаунт и ключ. [service_account_key_file](https://terraform-provider.yandexcloud.net).
---
### Ответ:
![terraform](https://github.com/valdemar-2502/Terraform-Basics.-Yandex-Cloud-Homework/blob/main/screenshots/01.png)
![terraform](https://github.com/valdemar-2502/Terraform-Basics.-Yandex-Cloud-Homework/blob/main/screenshots/02.png)
![terraform](https://github.com/valdemar-2502/Terraform-Basics.-Yandex-Cloud-Homework/blob/main/screenshots/03.png)
![terraform](https://github.com/valdemar-2502/Terraform-Basics.-Yandex-Cloud-Homework/blob/main/screenshots/04.png)
![terraform](https://github.com/valdemar-2502/Terraform-Basics.-Yandex-Cloud-Homework/blob/main/screenshots/05.png)
![terraform](https://github.com/valdemar-2502/Terraform-Basics.-Yandex-Cloud-Homework/blob/main/screenshots/06.png)
4. Сгенерируйте новый или используйте свой текущий ssh-ключ. Запишите его открытую(public) часть в переменную **vms_ssh_public_root_key**.
5. Инициализируйте проект, выполните код. Исправьте намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть.
### Ответ:
```
Анализ и исправление синтаксических ошибок в предоставленном коде:

Ошибка 1 в main.tf:

Строка: platform_id = "standart-v4"

Проблема: Опечатка в слове standard. Правильно standard-v2, standard-v3. standart — невалидное значение.

Исправление: platform_id = "standard-v3"

Ошибка 2 в main.tf:

Строка: core_fraction = 5

Проблема: Параметр core_fraction не является прямым аргументом блока resources. Он должен быть внутри блока resources.

Исправление: У нас он уже внутри блока resources, что верно. Ошибка здесь в том, что значение 5 может быть недопустимым для платформы standard-v3. Для standard-v3 допустимые значения core_fraction: 20, 50, 100. 5% не подходит.

Исправление: Меняем core_fraction = 5 на core_fraction = 20 внутри блока resources.
```
![terraform](https://github.com/valdemar-2502/Terraform-Basics.-Yandex-Cloud-Homework/blob/main/screenshots/07.png)
![terraform](https://github.com/valdemar-2502/Terraform-Basics.-Yandex-Cloud-Homework/blob/main/screenshots/08.png)
![terraform](https://github.com/valdemar-2502/Terraform-Basics.-Yandex-Cloud-Homework/blob/main/screenshots/09.png)
6. Подключитесь к консоли ВМ через ssh и выполните команду ``` curl ifconfig.me```.
Примечание: К OS ubuntu "out of a box, те из коробки" необходимо подключаться под пользователем ubuntu: ```"ssh ubuntu@vm_ip_address"```. Предварительно убедитесь, что ваш ключ добавлен в ssh-агент: ```eval $(ssh-agent) && ssh-add``` Вы познакомитесь с тем как при создании ВМ создать своего пользователя в блоке metadata в следующей лекции.;
![terraform](https://github.com/valdemar-2502/Terraform-Basics.-Yandex-Cloud-Homework/blob/main/screenshots/10.png)
![terraform](https://github.com/valdemar-2502/Terraform-Basics.-Yandex-Cloud-Homework/blob/main/screenshots/11.png)
8. Ответьте, как в процессе обучения могут пригодиться параметры ```preemptible = true``` и ```core_fraction=5``` в параметрах ВМ.
```
Ответ:

preemptible = true делает ВМ прерываемой. Такая ВМ стоит значительно дешевле, но может быть принудительно остановлена облачным провайдером в любой момент (обычно в течение 24 часов). В процессе обучения это крайне полезно, так как позволяет существенно экономить средства на тестовых стендах, которые не требуют постоянной работы.

core_fraction=5 (или другое значение, например, 20) позволяет создать ВМ с гарантированной долей vCPU. Это значит, что ВМ будет получать только указанный процент вычислительного времени от ядра. Это еще один инструмент экономии, идеально подходящий для легковесных тестовых сред, где не нужна полная мощность процессора.
```

В качестве решения приложите:

- скриншот ЛК Yandex Cloud с созданной ВМ, где видно внешний ip-адрес;
- скриншот консоли, curl должен отобразить тот же внешний ip-адрес;
- ответы на вопросы.


### Задание 2

1. Замените все хардкод-**значения** для ресурсов **yandex_compute_image** и **yandex_compute_instance** на **отдельные** переменные. К названиям переменных ВМ добавьте в начало префикс **vm_web_** .  Пример: **vm_web_name**.
2. Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их **default** прежними значениями из main.tf. 
3. Проверьте terraform plan. Изменений быть не должно. 
---
### Ответ:
![terraform](https://github.com/valdemar-2502/Terraform-Basics.-Yandex-Cloud-Homework/blob/main/screenshots/12.png)

---

### Задание 3

1. Создайте в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные первой ВМ.
2. Скопируйте блок ресурса и создайте с его помощью вторую ВМ в файле main.tf: **"netology-develop-platform-db"** ,  ```cores  = 2, memory = 2, core_fraction = 20```. Объявите её переменные с префиксом **vm_db_** в том же файле ('vms_platform.tf').  ВМ должна работать в зоне "ru-central1-b"
3. Примените изменения.
---
### Ответ:
![terraform](https://github.com/valdemar-2502/Terraform-Basics.-Yandex-Cloud-Homework/blob/main/screenshots/13.png)
![terraform](https://github.com/valdemar-2502/Terraform-Basics.-Yandex-Cloud-Homework/blob/main/screenshots/14.png)

---

### Задание 4

1. Объявите в файле outputs.tf **один** output , содержащий: instance_name, external_ip, fqdn для каждой из ВМ в удобном лично для вас формате.(без хардкода!!!)
2. Примените изменения.

В качестве решения приложите вывод значений ip-адресов команды ```terraform output```.

---
### Ответ:
![terraform](https://github.com/valdemar-2502/Terraform-Basics.-Yandex-Cloud-Homework/blob/main/screenshots/15.png)
![terraform](https://github.com/valdemar-2502/Terraform-Basics.-Yandex-Cloud-Homework/blob/main/screenshots/16.png)

---

### Задание 5

1. В файле locals.tf опишите в **одном** local-блоке имя каждой ВМ, используйте интерполяцию ${..} с НЕСКОЛЬКИМИ переменными по примеру из лекции.
2. Замените переменные внутри ресурса ВМ на созданные вами local-переменные.
3. Примените изменения.

---
### Ответ:
![terraform](https://github.com/valdemar-2502/Terraform-Basics.-Yandex-Cloud-Homework/blob/main/screenshots/17.png)

---

### Задание 6

1. Вместо использования трёх переменных  ".._cores",".._memory",".._core_fraction" в блоке  resources {...}, объедините их в единую map-переменную **vms_resources** и  внутри неё конфиги обеих ВМ в виде вложенного map(object).  
   ```
   пример из terraform.tfvars:
   vms_resources = {
     web={
       cores=2
       memory=2
       core_fraction=5
       hdd_size=10
       hdd_type="network-hdd"
       ...
     },
     db= {
       cores=2
       memory=4
       core_fraction=20
       hdd_size=10
       hdd_type="network-ssd"
       ...
     }
   }
   ```
3. Создайте и используйте отдельную map(object) переменную для блока metadata, она должна быть общая для всех ваших ВМ.
   ```
   пример из terraform.tfvars:
   metadata = {
     serial-port-enable = 1
     ssh-keys           = "ubuntu:ssh-ed25519 AAAAC..."
   }
   ```  
  
5. Найдите и закоментируйте все, более не используемые переменные проекта.
6. Проверьте terraform plan. Изменений быть не должно.

---
### Ответ:
![terraform](https://github.com/valdemar-2502/Terraform-Basics.-Yandex-Cloud-Homework/blob/main/screenshots/18.png)

---
------

## Дополнительное задание (со звёздочкой*)

**Настоятельно рекомендуем выполнять все задания со звёздочкой.**   
Они помогут глубже разобраться в материале. Задания со звёздочкой дополнительные, не обязательные к выполнению и никак не повлияют на получение вами зачёта по этому домашнему заданию. 


------
### Задание 7*

Изучите содержимое файла console.tf. Откройте terraform console, выполните следующие задания: 

1. Напишите, какой командой можно отобразить **второй** элемент списка test_list.
2. Найдите длину списка test_list с помощью функции length(<имя переменной>).
3. Напишите, какой командой можно отобразить значение ключа admin из map test_map.
4. Напишите interpolation-выражение, результатом которого будет: "John is admin for production server based on OS ubuntu-20-04 with X vcpu, Y ram and Z virtual disks", используйте данные из переменных test_list, test_map, servers и функцию length() для подстановки значений.

**Примечание**: если не догадаетесь как вычленить слово "admin", погуглите: "terraform get keys of map"

В качестве решения предоставьте необходимые команды и их вывод.

---
### Ответ:
![terraform](https://github.com/valdemar-2502/Terraform-Basics.-Yandex-Cloud-Homework/blob/main/screenshots/19.png)

---
------

### Задание 8*
1. Напишите и проверьте переменную test и полное описание ее type в соответствии со значением из terraform.tfvars:
```
test = [
  {
    "dev1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117",
      "10.0.1.7",
    ]
  },
  {
    "dev2" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@84.252.140.88",
      "10.0.2.29",
    ]
  },
  {
    "prod1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@51.250.2.101",
      "10.0.1.30",
    ]
  },
]
```
2. Напишите выражение в terraform console, которое позволит вычленить строку "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117" из этой переменной.
------

---
### Ответ:
![terraform](https://github.com/valdemar-2502/Terraform-Basics.-Yandex-Cloud-Homework/blob/main/screenshots/20.png)

---
------

### Задание 9*

Используя инструкцию https://cloud.yandex.ru/ru/docs/vpc/operations/create-nat-gateway#tf_1, настройте для ваших ВМ nat_gateway. Для проверки уберите внешний IP адрес (nat=false) у ваших ВМ и проверьте доступ в интернет с ВМ, подключившись к ней через serial console. Для подключения предварительно через ssh измените пароль пользователя: ```sudo passwd ubuntu```

---
### Ответ:
![terraform](https://github.com/valdemar-2502/Terraform-Basics.-Yandex-Cloud-Homework/blob/main/screenshots/21.png)
![terraform](https://github.com/valdemar-2502/Terraform-Basics.-Yandex-Cloud-Homework/blob/main/screenshots/22.png)
![terraform](https://github.com/valdemar-2502/Terraform-Basics.-Yandex-Cloud-Homework/blob/main/screenshots/23.png)
![terraform](https://github.com/valdemar-2502/Terraform-Basics.-Yandex-Cloud-Homework/blob/main/screenshots/24.png)
![terraform](https://github.com/valdemar-2502/Terraform-Basics.-Yandex-Cloud-Homework/blob/main/screenshots/25.png)
![terraform](https://github.com/valdemar-2502/Terraform-Basics.-Yandex-Cloud-Homework/blob/main/screenshots/26.png)
![terraform](https://github.com/valdemar-2502/Terraform-Basics.-Yandex-Cloud-Homework/blob/main/screenshots/27.png)

---

### Правила приёма работыДля подключения предварительно через ssh измените пароль пользователя: sudo passwd ubuntu
В качестве результата прикрепите ссылку на MD файл с описанием выполненой работы в вашем репозитории. Так же в репозитории должен присутсвовать ваш финальный код проекта.

**Важно. Удалите все созданные ресурсы**.


### Критерии оценки

Зачёт ставится, если:

* выполнены все задания,
* ответы даны в развёрнутой форме,
* приложены соответствующие скриншоты и файлы проекта,
* в выполненных заданиях нет противоречий и нарушения логики.

На доработку работу отправят, если:

* задание выполнено частично или не выполнено вообще,
* в логике выполнения заданий есть противоречия и существенные недостатки. 
