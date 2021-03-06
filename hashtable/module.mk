HASHTABLE_SRC_LIB := hashtable.c
HASHTABLE_SRC := $(HASHTABLE_SRC_LIB) hashtest.c hashperf.c sipperf.c

HASHTABLE_SRC_LIB := $(patsubst %,$(DIRHASHTABLE)/%,$(HASHTABLE_SRC_LIB))
HASHTABLE_SRC := $(patsubst %,$(DIRHASHTABLE)/%,$(HASHTABLE_SRC))

HASHTABLE_OBJ_LIB := $(patsubst %.c,%.o,$(HASHTABLE_SRC_LIB))
HASHTABLE_OBJ := $(patsubst %.c,%.o,$(HASHTABLE_SRC))

HASHTABLE_DEP_LIB := $(patsubst %.c,%.d,$(HASHTABLE_SRC_LIB))
HASHTABLE_DEP := $(patsubst %.c,%.d,$(HASHTABLE_SRC))

CFLAGS_HASHTABLE := -I$(DIRHASHLIST) -I$(DIRMISC)
LIBS_HASHTABLE := $(DIRMISC)/libmisc.a

MAKEFILES_HASHTABLE := $(DIRHASHTABLE)/module.mk

.PHONY: HASHTABLE clean_HASHTABLE distclean_HASHTABLE unit_HASHTABLE $(LCHASHTABLE) clean_$(LCHASHTABLE) distclean_$(LCHASHTABLE) unit_$(LCHASHTABLE)

$(LCHASHTABLE): HASHTABLE
clean_$(LCHASHTABLE): clean_HASHTABLE
distclean_$(LCHASHTABLE): distclean_HASHTABLE
unit_$(LCHASHTABLE): unit_HASHTABLE

HASHTABLE: $(DIRHASHTABLE)/libhashtable.a $(DIRHASHTABLE)/hashtest $(DIRHASHTABLE)/hashperf $(DIRHASHTABLE)/sipperf

unit_HASHTABLE: $(DIRHASHTABLE)/hashtest
	$(DIRHASHTABLE)/hashtest

$(DIRHASHTABLE)/libhashtable.a: $(HASHTABLE_OBJ_LIB) $(MAKEFILES_COMMON) $(MAKEFILES_HASHTABLE)
	rm -f $@
	ar rvs $@ $(filter %.o,$^)

$(DIRHASHTABLE)/hashtest: $(DIRHASHTABLE)/hashtest.o $(DIRHASHTABLE)/libhashtable.a $(LIBS_HASHTABLE) $(MAKEFILES_COMMON) $(MAKEFILES_HASHTABLE)
	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(filter %.a,$^) $(CFLAGS_HASHTABLE)

$(DIRHASHTABLE)/hashperf: $(DIRHASHTABLE)/hashperf.o $(DIRHASHTABLE)/libhashtable.a $(LIBS_HASHTABLE) $(MAKEFILES_COMMON) $(MAKEFILES_HASHTABLE)
	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(filter %.a,$^) $(CFLAGS_HASHTABLE)

$(DIRHASHTABLE)/sipperf: $(DIRHASHTABLE)/sipperf.o $(DIRHASHTABLE)/libhashtable.a $(LIBS_HASHTABLE) $(MAKEFILES_COMMON) $(MAKEFILES_HASHTABLE)
	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(filter %.a,$^) $(CFLAGS_HASHTABLE)

$(HASHTABLE_OBJ): %.o: %.c %.d $(MAKEFILES_COMMON) $(MAKEFILES_HASHTABLE)
	$(CC) $(CFLAGS) -c -o $*.o $*.c $(CFLAGS_HASHTABLE)
	$(CC) $(CFLAGS) -c -S -o $*.s $*.c $(CFLAGS_HASHTABLE)

$(HASHTABLE_DEP): %.d: %.c $(MAKEFILES_COMMON) $(MAKEFILES_HASHTABLE)
	$(CC) $(CFLAGS) -MM -MP -MT "$*.d $*.o" -o $*.d $*.c $(CFLAGS_HASHTABLE)

clean_HASHTABLE:
	rm -f $(HASHTABLE_OBJ) $(HASHTABLE_DEP)

distclean_HASHTABLE: clean_HASHTABLE
	rm -f $(DIRHASHTABLE)/libhashtable.a $(DIRHASHTABLE)/hashtest $(DIRHASHTABLE)/growtest $(DIRHASHTABLE)/hashperf $(DIRHASHTABLE)/sipperf

-include $(DIRHASHTABLE)/*.d
