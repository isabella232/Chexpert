FROM nvcr.io/nvidia/pytorch:20.10-py3

RUN apt-get update && apt-get install -y libgdcm-tools htop

COPY . /code
RUN pip --no-cache-dir install -r /code/requirements.txt

WORKDIR /code

CMD /bin/bash
