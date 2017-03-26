PORTS_SRC_LIB :=
PORTS_SRC := $(PORTS_SRC_LIB)

PORTS_SRC_LIB := $(patsubst %,$(DIRPORTS)/%,$(PORTS_SRC_LIB))
PORTS_SRC := $(patsubst %,$(DIRPORTS)/%,$(PORTS_SRC))

PORTS_OBJ_LIB := $(patsubst %.c,%.o,$(PORTS_SRC_LIB))
PORTS_OBJ := $(patsubst %.c,%.o,$(PORTS_SRC))

PORTS_DEP_LIB := $(patsubst %.c,%.d,$(PORTS_SRC_LIB))
PORTS_DEP := $(patsubst %.c,%.d,$(PORTS_SRC))

CFLAGS_PORTS := -I$(DIRHASHLIST) -I$(DIRMISC)

MAKEFILES_PORTS := $(DIRPORTS)/module.mk

.PHONY: PORTS clean_PORTS distclean_PORTS unit_PORTS $(LCPORTS) clean_$(LCPORTS) distclean_$(LCPORTS) unit_$(LCPORTS)

$(LCPORTS): PORTS
clean_$(LCPORTS): clean_PORTS
distclean_$(LCPORTS): distclean_PORTS

PORTS: $(DIRPORTS)/libports.a

unit_PORTS:
	@true

$(DIRPORTS)/libports.a: $(PORTS_OBJ_LIB) $(MAKEFILES_COMMON) $(MAKEFILES_PORTS)
	rm -f $@
	ar rvs $@ $(filter %.o,$^)

$(PORTS_OBJ): %.o: %.c $(PORTS_DEP) $(MAKEFILES_COMMON) $(MAKEFILES_PORTS)
	$(CC) $(CFLAGS) -c -o $*.o $*.c $(CFLAGS_PORTS)

$(PORTS_DEP): %.d: %.c $(MAKEFILES_COMMON) $(MAKEFILES_PORTS)
	$(CC) $(CFLAGS) -MM -MP -MT "$*.d $*.o" -o $*.d $*.c $(CFLAGS_PORTS)

clean_PORTS:
	rm -f $(PORTS_OBJ) $(PORTS_DEP)

distclean_PORTS: clean_PORTS
	rm -f $(DIRPORTS)/libports.a

-include $(DIRPORTS)/*.d