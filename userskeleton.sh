#!/bin/sh

useradd gms
passwd gms
mkdir /home/gms/public_html
chown -R gms:gms /home/gms/

useradd kesehatan
passwd kesehatan
mkdir /home/kesehatan/public_html
chown -R kesehatan:kesehatan /home/kesehatan/

useradd konsumsi
passwd konsumsi
mkdir /home/konsumsi/public_html
chown -R konsumsi:konsumsi /home/konsumsi/


useradd core
passwd core
mkdir /home/core/public_html
chown -R core:core /home/core/

useradd transportasi
passwd transportasi
mkdir /home/transportasi/public_html
chown -R transportasi:transportasi /home/transportasi/

useradd hubda
passwd hubda
mkdir /home/hubda/public_html
chown -R hubda:hubda /home/hubda/

useradd akomodasi
passwd akomodasi
mkdir /home/akomodasi/public_html
chown -R akomodasi:akomodasi /home/akomodasi/

useradd reg-akre
passwd reg-akre
mkdir /home/reg-akre/public_html
chown -R reg-akre:reg-akre /home/reg-akre/

useradd office
passwd office
mkdir /home/office/public_html
chown -R office:office /home/office/

useradd demo
passwd demo
mkdir /home/demo/public_html
chown -R demo:demo /home/demo/

useradd auth
passwd auth
mkdir /home/auth/public_html
chown -R auth:auth /home/auth/

useradd perlengkapan
passwd perlengkapan
mkdir /home/perlengkapan/public_html
chown -R perlengkapan:perlengkapan /home/perlengkapan/

useradd helpdesk
passwd helpdesk
mkdir /home/helpdesk/public_html
chown -R helpdesk:helpdesk /home/helpdesk/

useradd ppm
passwd ppm
mkdir /home/ppm/public_html
chown -R ppm:ppm /home/ppm/

useradd sdm
passwd sdm
mkdir /home/sdm/public_html
chown -R sdm:sdm /home/sdm/

useradd user-ref
passwd user-ref
mkdir /home/user-ref/public_html
chown -R user-ref:user-ref /home/user-ref/

useradd dashboard
passwd dashboard
mkdir /home/dashboard/public_html
chown -R dashboard:dashboard /home/dashboard/

