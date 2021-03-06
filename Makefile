OBJS = src/sigma_mis/sigma_mis_at_r.o src/sigma_mis/sigma_mis.o src/delta_sigma_mis/delta_sigma_mis_at_r.o src/delta_sigma_mis/delta_sigma_mis.o src/miscentered_sigma/miscentered_sigma.o src/miscentered_sigma/miscentered_sigma_at_r.o src/miscentered_delta_sigma/miscentered_delta_sigma.o src/miscentered_delta_sigma/miscentered_delta_sigma_at_r.o src/ave_miscentered_delta_sigma/ave_miscentered_delta_sigma.o src/ave_miscentered_delta_sigma/ave_miscentered_delta_sigma_in_bin.o src/wrapper/wrapper.o

CC = gcc
EXEC =
CEXEC = ./main.exe
PYEXEC = ./src/wrapper/Delta_Sigma_miscentering.so

ifdef ALONE
ifeq ($(ALONE),yes)
EXEC += $(CEXEC)
CFLAGS = -pg
OFLAGS = -pg
OBJS += main.o
endif
else
EXEC += $(PYEXEC)
CFLAGS = -fPIC
OFLAGS = -shared 
endif

INCL = -I${GSLI} -O2
LIBS = -lgsl -lgslcblas -L${GSLL} -lm -O2
DFLAGS =

all : $(EXEC)
	@echo "Compilation complete."

%.o: %.c
	$(CC) $(CFLAGS) $(DFLAGS) $(INCL) -c $^ -o $@

$(EXEC) : $(OBJS)
	$(CC) $(OFLAGS) $^ $(LIBS) -o $(EXEC)

.PHONY : clean all

clean:
	@rm -f $(OBJS) main.o $(CEXEC) $(PYEXEC)
	@echo "Cleanup complete."
