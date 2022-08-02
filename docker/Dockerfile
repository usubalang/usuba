FROM ubuntu:focal

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update &&                                                           \
    apt-get install -qq                                                         \
                    clang-8                                                     \
                    cloc                                                        \
                    cpio                                                        \
                    gcc-8                                                       \
                    git                                                         \
                    libdata-printer-perl                                        \
                    m4                                                          \
                    make                                                        \
                    ocaml                                                       \
                    opam                                                        \
                    cpanminus                                                   \
                    perl-doc                                                    \
                    sudo                                                        \
                    wget &&                                                     \
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-8 1000 && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-8 1000 && \
    useradd -d /home/eval -m -s /bin/bash eval &&                               \
    echo "eval ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/eval &&                \
    chmod 0440 /etc/sudoers.d/eval &&                                           \
    passwd -l eval &&                                                           \
    chown -R eval:eval /home/eval

 # &&                                            \
#    rm -rf /var/lib/apt/lists/*

USER eval
ENV HOME /home/eval
WORKDIR /home/eval

# Bring Coq, Menhir, and dune
RUN opam init --disable-sandboxing -a -y && \
    opam install -y -j4 coq.8.8.1           \
                        menhir.20180905
                        #dune which version?

# Bring up Perl dependencies
RUN sudo cpanm install -f App::cpanminus \
                        Crypt::Mode::ECB \
                        Crypt::Mode::CTR \
                        File::Copy::Recursive \
                        JSON \
                        List::MoreUtils \
                        Data::Printer \
                        Statistics::Test::WilcoxonRankSum \
                        require::relative

# Bring ICC
COPY --chown=eval config.cfg /tmp/icc-config.cfg

# Note: provide a (valid) Intel activation key
ARG ACTIVATION_SERIAL_NUMBER

# RUN cd /tmp && mkdir intel && \
#     echo ACTIVATION_SERIAL_NUMBER=$ACTIVATION_SERIAL_NUMBER >> /tmp/icc-config.cfg && \
#     wget -O icc.tgz http://registrationcenter-download.intel.com/akdlm/irc_nas/tec/12717/parallel_studio_xe_2018_update2_cluster_edition_online.tgz && \
#     tar -xvzf icc.tgz && \
#     cd parallel_studio_xe_2018_update2_cluster_edition_online && \
#     bash install.sh --silent=/tmp/icc-config.cfg --cli-mode --user-mode && \
#     cd .. && \
#     rm -rf parallel_studio_xe_2018_update2_cluster_edition_online icc.tgz \
#            /tmp/icc-config.cfg

ENV PATH="/home/eval/intel/bin/:${PATH}"
ENV INTEL_LICENSE_FILE="/home/eval/intel/licenses/"

# Add instructions on Bash startup
COPY motd.sh $HOME/
RUN echo ". ~/motd.sh" >> $HOME/.bashrc

# Bring Usuba (not from live repo)
RUN git clone https://github.com/DadaIsCrazy/usuba.git && \ 
    git clone --recursive https://github.com/usubalang/benchmarks.git  

# Add new layer after cloning is finished
WORKDIR /home/eval/usuba
RUN ulimit -s unlimited && opam exec -- make



#RUN cd ~/benchmarks/ && perl run_benchs.pl" ]


