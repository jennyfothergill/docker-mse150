# How to build? (optional) (version is docker container related, not mbuild version)
# docker build . -f Dockerfile  -t cmelab/mse150

# How to run?
# docker run --rm -itp 8888:8888 cmelab/mse150:latest jupyter notebook --notebook-dir=/home/ --ip='*' --port=8888 --no-browser --allow-root
# How to run just like it'll appear on codelab (or elsewhere)
# docker run --rm -itp 8888:8888 cmelab/mse150:latest jupyter notebook --notebook-dir=/home/jovyan --ip='*' --port=8888 --no-browser --allow-root

FROM cmelab/mbuild

RUN apk update && \
    apk add nano less R R-dev texlive-xetex && \
    conda install -y matplotlib jupyter && \
    conda clean -tipsy

RUN adduser -G root -S jovyan && \
    chown -R jovyan /opt/conda/ /home/jovyan
ENV NB_USER jovyan
USER $NB_USER
ENV XDG_CACHE_HOME /home/$NB_USER/.cache/
RUN MPLBACKEND=Agg $CONDA_DIR/bin/python -c "import matplotlib.pyplot"
WORKDIR /home/jovyan
ADD --chown=jovyan:root intro/ /home/jovyan/
ADD --chown=jovyan:root swc_files/ /home/jovyan/
ADD --chown=jovyan:root dotfiles/ /home/jovyan/
CMD jupyter notebook --port=8888 --ip='*' --no-browser --notebook-dir=/home/jovyan --NotebookApp.iopub_data_rate_limit=100000000
