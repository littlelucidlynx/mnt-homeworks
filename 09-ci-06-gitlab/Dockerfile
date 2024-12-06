FROM centos:7

RUN sed -i 's|mirrorlist=|#mirrorlist=|g' /etc/yum.repos.d/CentOS-*.repo && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*.repo

RUN yum -y update && \
    yum install -y python3 python3-pip curl && \
    yum clean all


COPY requirements.txt /tmp/requirements.txt
RUN pip3 install --no-cache-dir -r /tmp/requirements.txt


RUN mkdir -p /python_api
COPY python-api.py /python_api/python-api.py


WORKDIR /python_api
CMD ["python3", "/python_api/python-api.py"]