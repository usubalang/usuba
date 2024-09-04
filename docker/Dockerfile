FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update &&                                                            \
    apt-get install -qq --no-install-recommends                                  \
                    sudo                                                         \
                    clang-11                                                     \
                    gcc-10                                                       \
                    opam                                                         \
                    cpanminus                                                    \
                    git                                                          \
                    ssh                                                          \
                    ca-certificates &&                                           \
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-11 1000 && \
    useradd -d /home/eval -m -s /bin/bash eval &&                                \
    echo "eval ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/eval &&                 \
    chmod 0440 /etc/sudoers.d/eval &&                                            \
    passwd -l eval &&                                                            \
    chown -R eval:eval /home/eval

USER eval
ENV HOME /home/eval
WORKDIR /home/eval

# Setup opam
RUN opam init --disable-sandboxing -a -y && \
    opam install dune

# Bring up Usuba
RUN git clone --recurse-submodules https://github.com/usubalang/usuba.git &&      \
    git clone --recurse-submodules https://github.com/usubalang/benchmarks.git && \
    cd usuba &&                                                                   \
    opam switch create . --yes --deps-only --with-doc --with-test &&              \
    opam exec -- ./configure

# Bring up Perl dependencies (for benchmarks)
RUN sudo cpanm install -f File::Copy::Recursive             \
                          JSON                              \
                          Statistics::Test::WilcoxonRankSum \
                          Parallel::ForkManager

ENTRYPOINT [ "opam", "exec", "--"]
CMD ["/bin/bash", "-c", "ulimit -s unlimited && cd benchmarks && perl bench_perfs.pl" ]
