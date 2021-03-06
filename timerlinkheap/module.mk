TIMERLINKHEAP_SRC_LIB := timerlink.c timerlinkwheel.c
TIMERLINKHEAP_SRC := $(TIMERLINKHEAP_SRC_LIB) timertest.c timertest2.c timerlinkwheeltest.c timerlinkwheelperf.c

TIMERLINKHEAP_SRC_LIB := $(patsubst %,$(DIRTIMERLINKHEAP)/%,$(TIMERLINKHEAP_SRC_LIB))
TIMERLINKHEAP_SRC := $(patsubst %,$(DIRTIMERLINKHEAP)/%,$(TIMERLINKHEAP_SRC))

TIMERLINKHEAP_OBJ_LIB := $(patsubst %.c,%.o,$(TIMERLINKHEAP_SRC_LIB))
TIMERLINKHEAP_OBJ := $(patsubst %.c,%.o,$(TIMERLINKHEAP_SRC))

TIMERLINKHEAP_DEP_LIB := $(patsubst %.c,%.d,$(TIMERLINKHEAP_SRC_LIB))
TIMERLINKHEAP_DEP := $(patsubst %.c,%.d,$(TIMERLINKHEAP_SRC))

CFLAGS_TIMERLINKHEAP := -I$(DIRHASHLIST) -I$(DIRMISC)

MAKEFILES_TIMERLINKHEAP := $(DIRTIMERLINKHEAP)/module.mk

.PHONY: TIMERLINKHEAP clean_TIMERLINKHEAP distclean_TIMERLINKHEAP unit_TIMERLINKHEAP $(LCTIMERLINKHEAP) clean_$(LCTIMERLINKHEAP) distclean_$(LCTIMERLINKHEAP) unit_$(LCTIMERLINKHEAP)

$(LCTIMERLINKHEAP): TIMERLINKHEAP
clean_$(LCTIMERLINKHEAP): clean_TIMERLINKHEAP
distclean_$(LCTIMERLINKHEAP): distclean_TIMERLINKHEAP
unit_$(LCTIMERLINKHEAP): unit_TIMERLINKHEAP

TIMERLINKHEAP: $(DIRTIMERLINKHEAP)/libtimerlinkheap.a $(DIRTIMERLINKHEAP)/timertest $(DIRTIMERLINKHEAP)/timertest2 $(DIRTIMERLINKHEAP)/timerlinkwheeltest $(DIRTIMERLINKHEAP)/timerlinkwheelperf

unit_TIMERLINKHEAP:
	@true

$(DIRTIMERLINKHEAP)/libtimerlinkheap.a: $(TIMERLINKHEAP_OBJ_LIB) $(MAKEFILES_COMMON) $(MAKEFILES_TIMERLINKHEAP)
	rm -f $@
	ar rvs $@ $(filter %.o,$^)

$(DIRTIMERLINKHEAP)/timertest: $(DIRTIMERLINKHEAP)/timertest.o $(DIRTIMERLINKHEAP)/libtimerlinkheap.a $(MAKEFILES_COMMON) $(MAKEFILES_TIMERLINKHEAP)
	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(filter %.a,$^) $(CFLAGS_TIMERLINKHEAP)

$(DIRTIMERLINKHEAP)/timertest2: $(DIRTIMERLINKHEAP)/timertest2.o $(DIRTIMERLINKHEAP)/libtimerlinkheap.a $(MAKEFILES_COMMON) $(MAKEFILES_TIMERLINKHEAP)
	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(filter %.a,$^) $(CFLAGS_TIMERLINKHEAP)

$(DIRTIMERLINKHEAP)/timerlinkwheeltest: $(DIRTIMERLINKHEAP)/timerlinkwheeltest.o $(DIRTIMERLINKHEAP)/libtimerlinkheap.a $(MAKEFILES_COMMON) $(MAKEFILES_TIMERLINKHEAP)
	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(filter %.a,$^) $(CFLAGS_TIMERLINKHEAP)

$(DIRTIMERLINKHEAP)/timerlinkwheelperf: $(DIRTIMERLINKHEAP)/timerlinkwheelperf.o $(DIRTIMERLINKHEAP)/libtimerlinkheap.a $(MAKEFILES_COMMON) $(MAKEFILES_TIMERLINKHEAP)
	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(filter %.a,$^) $(CFLAGS_TIMERLINKHEAP)

$(TIMERLINKHEAP_OBJ): %.o: %.c %.d $(MAKEFILES_COMMON) $(MAKEFILES_TIMERLINKHEAP)
	$(CC) $(CFLAGS) -c -o $*.o $*.c $(CFLAGS_TIMERLINKHEAP)
	$(CC) $(CFLAGS) -c -S -o $*.s $*.c $(CFLAGS_TIMERLINKHEAP)

$(TIMERLINKHEAP_DEP): %.d: %.c $(MAKEFILES_COMMON) $(MAKEFILES_TIMERLINKHEAP)
	$(CC) $(CFLAGS) -MM -MP -MT "$*.d $*.o" -o $*.d $*.c $(CFLAGS_TIMERLINKHEAP)

clean_TIMERLINKHEAP:
	rm -f $(TIMERLINKHEAP_OBJ) $(TIMERLINKHEAP_DEP)

distclean_TIMERLINKHEAP: clean_TIMERLINKHEAP
	rm -f $(DIRTIMERLINKHEAP)/libtimerlinkheap.a $(DIRTIMERLINKHEAP)/timertest $(DIRTIMERLINKHEAP)/timertest2 $(DIRTIMERLINKHEAP)/timerlinkwheeltest $(DIRTIMERLINKHEAP)/timerlinkwheelperf

-include $(DIRTIMERLINKHEAP)/*.d
