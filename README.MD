### Данный проект пересобран под Ubuntu 
### Проект разбит на роли
### Sonar и СУБД установлены на разные машины, сопрягаются по локальному ip.
### Локальный ip вытаскивается в Ansible (с помощью terraform outputs с указанием пути к файлу .tfstate) в блоке localhost и подставляется в vars.yaml
### Версия nexus изменена на последннюю взятую с github
### Запуск плэйбука происходит автоматически из main.tf в нем указан путь к ansible.cfg что бы сохранить пути к дерикториям

## Sonar

```
sypchik@Mirror:~$ wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-6.2.1.4610-linux-x64.zip
--2024-12-04 00:44:47--  https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-6.2.1.4610-linux-x64.zip
Resolving binaries.sonarsource.com (binaries.sonarsource.com)... 108.156.22.35, 108.156.22.103, 108.156.22.52, ...
Connecting to binaries.sonarsource.com (binaries.sonarsource.com)|108.156.22.35|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 57996219 (55M) [binary/octet-stream]
Saving to: ‘sonar-scanner-cli-6.2.1.4610-linux-x64.zip’

sonar-scanner-cli-6.2.1.4610-linux-x64.zip            100%[=========================================================================================================================>]  55,31M  6,21MB/s    in 11s     

2024-12-04 00:44:58 (5,14 MB/s) - ‘sonar-scanner-cli-6.2.1.4610-linux-x64.zip’ saved [57996219/57996219]

sypchik@Mirror:~$ sudo apt install unzip
sypchik@Mirror:~/sonar-scanner-6.2.1.4610-linux-x64$ export PATH=$PATH:/home/sypchik/sonar-scanner-6.2.1.4610-linux-x64/bin

sypchik@Mirror:~$ sonar-scanner -v
01:05:24.605 INFO  Scanner configuration file: /home/sypchik/sonar-scanner-6.2.1.4610-linux-x64/conf/sonar-scanner.properties
01:05:24.610 INFO  Project root configuration file: NONE
01:05:24.630 INFO  SonarScanner CLI 6.2.1.4610
01:05:24.632 INFO  Java 17.0.12 Eclipse Adoptium (64-bit)
01:05:24.633 INFO  Linux 5.15.167.4-microsoft-standard-WSL2 amd64

 sonar-scanner \
  -Dsonar.projectKey=Sypchik \
  -Dsonar.sources=/home/sypchik/hw-cicd9/example/ \
  -Dsonar.host.url=http://89.169.159.248:9000 \
  -Dsonar.login=024affd676e2ec567e222164f350b1c88b185a32
01:10:26.780 INFO  Scanner configuration file: /home/sypchik/sonar-scanner-6.2.1.4610-linux-x64/conf/sonar-scanner.properties
01:10:26.784 INFO  Project root configuration file: NONE
01:10:26.801 INFO  SonarScanner CLI 6.2.1.4610
01:10:26.803 INFO  Java 17.0.12 Eclipse Adoptium (64-bit)
01:10:26.804 INFO  Linux 5.15.167.4-microsoft-standard-WSL2 amd64
01:10:26.834 INFO  User cache: /home/sypchik/.sonar/cache
01:10:28.667 INFO  Communicating with SonarQube Server 9.1.0.47736
01:10:28.875 INFO  Load global settings
01:10:29.083 INFO  Load global settings (done) | time=208ms
01:10:29.084 INFO  Server id: F6D84DB3-AZOOb3xfPJABHH8Csz6G
01:10:29.087 INFO  User cache: /home/sypchik/.sonar/cache
01:10:29.089 INFO  Load/download plugins
01:10:29.090 INFO  Load plugins index
01:10:29.182 INFO  Load plugins index (done) | time=92ms
01:10:29.235 INFO  Load/download plugins (done) | time=146ms
01:10:29.599 INFO  Process project properties
01:10:29.607 INFO  Process project properties (done) | time=8ms
01:10:29.608 INFO  Execute project builders
01:10:29.610 INFO  Execute project builders (done) | time=2ms
01:10:29.614 INFO  Project key: Sypchik
01:10:29.614 INFO  Base dir: /home/sypchik
01:10:29.614 INFO  Working dir: /home/sypchik/.scannerwork
01:10:30.374 INFO  Load project settings for component key: 'Sypchik'
01:10:30.795 INFO  Load project settings for component key: 'Sypchik' (done) | time=421ms
01:10:30.828 INFO  Load quality profiles
01:10:30.952 INFO  Load quality profiles (done) | time=124ms
01:10:30.957 INFO  Load active rules
01:10:34.513 INFO  Load active rules (done) | time=3556ms
01:10:34.527 WARN  SCM provider autodetection failed. Please use "sonar.scm.provider" to define SCM of your project, or disable the SCM Sensor in the project settings.
01:10:34.561 INFO  Indexing files...
01:10:34.561 INFO  Project configuration:
01:10:34.584 INFO  1 file indexed
01:10:34.585 INFO  Quality profile for py: Sonar way
01:10:34.585 INFO  ------------- Run sensors on module Sypchik
01:10:34.652 INFO  Load metrics repository
01:10:35.047 INFO  Load metrics repository (done) | time=395ms
01:10:35.633 INFO  Sensor Python Sensor [python]
01:10:35.638 WARN  Your code is analyzed as compatible with python 2 and 3 by default. This will prevent the detection of issues specific to python 2 or python 3. You can get a more precise analysis by setting a python version in your configuration via the parameter "sonar.python.version"
01:10:35.644 INFO  Starting global symbols computation
01:10:35.646 INFO  1 source file to be analyzed
01:10:35.655 INFO  Load project repositories
01:10:35.742 INFO  Load project repositories (done) | time=87ms
01:10:35.941 INFO  1/1 source file has been analyzed
01:10:35.941 INFO  Starting rules execution
01:10:35.942 INFO  1 source file to be analyzed
01:10:36.214 INFO  1/1 source file has been analyzed
01:10:36.215 INFO  Sensor Python Sensor [python] (done) | time=582ms
01:10:36.215 INFO  Sensor Cobertura Sensor for Python coverage [python]
01:11:47.495 INFO  Sensor Cobertura Sensor for Python coverage [python] (done) | time=71279ms
01:11:47.495 INFO  Sensor PythonXUnitSensor [python]
01:12:57.832 INFO  Sensor PythonXUnitSensor [python] (done) | time=70337ms
01:12:57.833 INFO  Sensor CSS Rules [cssfamily]
01:12:57.834 INFO  No CSS, PHP, HTML or VueJS files are found in the project. CSS analysis is skipped.
01:12:57.834 INFO  Sensor CSS Rules [cssfamily] (done) | time=1ms
01:12:57.834 INFO  Sensor JaCoCo XML Report Importer [jacoco]
01:12:57.835 INFO  'sonar.coverage.jacoco.xmlReportPaths' is not defined. Using default locations: target/site/jacoco/jacoco.xml,target/site/jacoco-it/jacoco.xml,build/reports/jacoco/test/jacocoTestReport.xml
01:12:57.836 INFO  No report imported, no coverage information will be imported by JaCoCo XML Report Importer
01:12:57.836 INFO  Sensor JaCoCo XML Report Importer [jacoco] (done) | time=2ms
01:12:57.836 INFO  Sensor C# Project Type Information [csharp]
01:12:57.837 INFO  Sensor C# Project Type Information [csharp] (done) | time=1ms
01:12:57.837 INFO  Sensor C# Analysis Log [csharp]
01:12:57.846 INFO  Sensor C# Analysis Log [csharp] (done) | time=9ms
01:12:57.846 INFO  Sensor C# Properties [csharp]
01:12:57.847 INFO  Sensor C# Properties [csharp] (done) | time=1ms
01:12:57.847 INFO  Sensor JavaXmlSensor [java]
01:12:57.849 INFO  Sensor JavaXmlSensor [java] (done) | time=2ms
01:12:57.849 INFO  Sensor HTML [web]
01:12:57.851 INFO  Sensor HTML [web] (done) | time=2ms
01:12:57.852 INFO  Sensor VB.NET Project Type Information [vbnet]
01:12:57.852 INFO  Sensor VB.NET Project Type Information [vbnet] (done) | time=0ms
01:12:57.852 INFO  Sensor VB.NET Analysis Log [vbnet]
01:12:57.862 INFO  Sensor VB.NET Analysis Log [vbnet] (done) | time=10ms
01:12:57.863 INFO  Sensor VB.NET Properties [vbnet]
01:12:57.863 INFO  Sensor VB.NET Properties [vbnet] (done) | time=0ms
01:12:57.867 INFO  ------------- Run sensors on project
01:12:57.879 INFO  Sensor Zero Coverage Sensor
01:12:57.891 INFO  Sensor Zero Coverage Sensor (done) | time=11ms
01:12:57.892 INFO  SCM Publisher No SCM system was detected. You can use the 'sonar.scm.provider' property to explicitly specify it.
01:12:57.895 INFO  CPD Executor Calculating CPD for 1 file
01:12:57.904 INFO  CPD Executor CPD calculation finished (done) | time=9ms
01:12:57.957 INFO  Analysis report generated in 51ms, dir size=103,2 kB
01:12:57.971 INFO  Analysis report compressed in 14ms, zip size=14,3 kB
01:12:58.184 INFO  Analysis report uploaded in 211ms
01:12:58.185 INFO  ANALYSIS SUCCESSFUL, you can browse http://89.169.159.248:9000/dashboard?id=Sypchik
01:12:58.186 INFO  Note that you will be able to access the updated dashboard once the server has processed the submitted analysis report
01:12:58.186 INFO  More about the report processing at http://89.169.159.248:9000/api/ce/task?id=AZOOlWlePJABHH8Cs4_x
01:12:58.189 INFO  Analysis total time: 2:28.894 s
01:12:58.190 INFO  EXECUTION SUCCESS
01:12:58.191 INFO  Total time: 2:31.414s

### Reconfig file

 sonar-scanner   -Dsonar.projectKey=Sypchik   -Dsonar.sources=/home/sypchik/hw-cicd9/example/   -Dsonar.host.url=http://89.169.159.248:9000   -Dsonar.login=024affd676e2ec567e222164f350b1c88b185a32
01:25:01.186 INFO  Scanner configuration file: /home/sypchik/sonar-scanner-6.2.1.4610-linux-x64/conf/sonar-scanner.properties
01:25:01.189 INFO  Project root configuration file: NONE
01:25:01.208 INFO  SonarScanner CLI 6.2.1.4610
01:25:01.210 INFO  Java 17.0.12 Eclipse Adoptium (64-bit)
01:25:01.211 INFO  Linux 5.15.167.4-microsoft-standard-WSL2 amd64
01:25:01.242 INFO  User cache: /home/sypchik/.sonar/cache
01:25:04.172 INFO  Communicating with SonarQube Server 9.1.0.47736
01:25:04.390 INFO  Load global settings
01:25:04.573 INFO  Load global settings (done) | time=183ms
01:25:04.575 INFO  Server id: F6D84DB3-AZOOb3xfPJABHH8Csz6G
01:25:04.577 INFO  User cache: /home/sypchik/.sonar/cache
01:25:04.580 INFO  Load/download plugins
01:25:04.581 INFO  Load plugins index
01:25:04.685 INFO  Load plugins index (done) | time=104ms
01:25:04.746 INFO  Load/download plugins (done) | time=166ms
01:25:05.097 INFO  Process project properties
01:25:05.104 INFO  Process project properties (done) | time=7ms
01:25:05.105 INFO  Execute project builders
01:25:05.107 INFO  Execute project builders (done) | time=2ms
01:25:05.110 INFO  Project key: Sypchik
01:25:05.111 INFO  Base dir: /home/sypchik
01:25:05.111 INFO  Working dir: /home/sypchik/.scannerwork
01:25:05.213 INFO  Load project settings for component key: 'Sypchik'
01:25:05.294 INFO  Load project settings for component key: 'Sypchik' (done) | time=81ms
01:25:05.336 INFO  Load quality profiles
01:25:05.449 INFO  Load quality profiles (done) | time=113ms
01:25:05.455 INFO  Load active rules
01:25:10.279 INFO  Load active rules (done) | time=4824ms
01:25:10.293 WARN  SCM provider autodetection failed. Please use "sonar.scm.provider" to define SCM of your project, or disable the SCM Sensor in the project settings.
01:25:10.329 INFO  Indexing files...
01:25:10.330 INFO  Project configuration:
01:25:10.350 INFO  1 file indexed
01:25:10.350 INFO  Quality profile for py: Sonar way
01:25:10.351 INFO  ------------- Run sensors on module Sypchik
01:25:10.416 INFO  Load metrics repository
01:25:10.527 INFO  Load metrics repository (done) | time=111ms
01:25:11.144 INFO  Sensor Python Sensor [python]
01:25:11.150 WARN  Your code is analyzed as compatible with python 2 and 3 by default. This will prevent the detection of issues specific to python 2 or python 3. You can get a more precise analysis by setting a python version in your configuration via the parameter "sonar.python.version"
01:25:11.159 INFO  Starting global symbols computation
01:25:11.161 INFO  1 source file to be analyzed
01:25:11.171 INFO  Load project repositories
01:25:11.235 INFO  Load project repositories (done) | time=64ms
01:25:11.428 INFO  1/1 source file has been analyzed
01:25:11.429 INFO  Starting rules execution
01:25:11.429 INFO  1 source file to be analyzed
01:25:11.559 INFO  1/1 source file has been analyzed
01:25:11.560 INFO  Sensor Python Sensor [python] (done) | time=416ms
01:25:11.560 INFO  Sensor Cobertura Sensor for Python coverage [python]
01:26:24.843 INFO  Sensor Cobertura Sensor for Python coverage [python] (done) | time=73283ms
01:26:24.843 INFO  Sensor PythonXUnitSensor [python]
01:27:36.108 INFO  Sensor PythonXUnitSensor [python] (done) | time=71265ms
01:27:36.109 INFO  Sensor CSS Rules [cssfamily]
01:27:36.109 INFO  No CSS, PHP, HTML or VueJS files are found in the project. CSS analysis is skipped.
01:27:36.110 INFO  Sensor CSS Rules [cssfamily] (done) | time=2ms
01:27:36.110 INFO  Sensor JaCoCo XML Report Importer [jacoco]
01:27:36.111 INFO  'sonar.coverage.jacoco.xmlReportPaths' is not defined. Using default locations: target/site/jacoco/jacoco.xml,target/site/jacoco-it/jacoco.xml,build/reports/jacoco/test/jacocoTestReport.xml
01:27:36.112 INFO  No report imported, no coverage information will be imported by JaCoCo XML Report Importer
01:27:36.113 INFO  Sensor JaCoCo XML Report Importer [jacoco] (done) | time=3ms
01:27:36.113 INFO  Sensor C# Project Type Information [csharp]
01:27:36.113 INFO  Sensor C# Project Type Information [csharp] (done) | time=0ms
01:27:36.114 INFO  Sensor C# Analysis Log [csharp]
01:27:36.123 INFO  Sensor C# Analysis Log [csharp] (done) | time=9ms
01:27:36.123 INFO  Sensor C# Properties [csharp]
01:27:36.123 INFO  Sensor C# Properties [csharp] (done) | time=0ms
01:27:36.123 INFO  Sensor JavaXmlSensor [java]
01:27:36.124 INFO  Sensor JavaXmlSensor [java] (done) | time=1ms
01:27:36.125 INFO  Sensor HTML [web]
01:27:36.128 INFO  Sensor HTML [web] (done) | time=3ms
01:27:36.128 INFO  Sensor VB.NET Project Type Information [vbnet]
01:27:36.129 INFO  Sensor VB.NET Project Type Information [vbnet] (done) | time=1ms
01:27:36.129 INFO  Sensor VB.NET Analysis Log [vbnet]
01:27:36.142 INFO  Sensor VB.NET Analysis Log [vbnet] (done) | time=13ms
01:27:36.142 INFO  Sensor VB.NET Properties [vbnet]
01:27:36.142 INFO  Sensor VB.NET Properties [vbnet] (done) | time=0ms
01:27:36.146 INFO  ------------- Run sensors on project
01:27:36.157 INFO  Sensor Zero Coverage Sensor
01:27:36.167 INFO  Sensor Zero Coverage Sensor (done) | time=10ms
01:27:36.169 INFO  SCM Publisher No SCM system was detected. You can use the 'sonar.scm.provider' property to explicitly specify it.
01:27:36.170 INFO  CPD Executor Calculating CPD for 1 file
01:27:36.181 INFO  CPD Executor CPD calculation finished (done) | time=7ms
01:27:36.236 INFO  Analysis report generated in 53ms, dir size=103,0 kB
01:27:36.248 INFO  Analysis report compressed in 11ms, zip size=14,0 kB
01:27:36.597 INFO  Analysis report uploaded in 348ms
01:27:36.598 INFO  ANALYSIS SUCCESSFUL, you can browse http://89.169.159.248:9000/dashboard?id=Sypchik
01:27:36.598 INFO  Note that you will be able to access the updated dashboard once the server has processed the submitted analysis report
01:27:36.599 INFO  More about the report processing at http://89.169.159.248:9000/api/ce/task?id=AZOOotAHPJABHH8Cs4_0
01:27:36.602 INFO  Analysis total time: 2:31.794 s
01:27:36.603 INFO  EXECUTION SUCCESS
01:27:36.604 INFO  Total time: 2:35.423s
```


