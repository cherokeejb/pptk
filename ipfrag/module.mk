IPFRAG_SRC_LIB := ipfrag.c ipreass.c rfc815.c combo.c linux.c rfc791.c iprbexplicit.c iprb815.c
IPFRAG_SRC := $(IPFRAG_SRC_LIB) ipfragtest.c ipreasstest.c rfc815test.c combotest.c rfc815perf.c ipreassperf.c comboperf.c linuxperf.c rfc791test.c rfc791perf.c linuxtest.c iprbexplicittest.c iprbexplicitperf.c ipreassworst.c iprbexplicitworst.c iprb815test.c iprb815perf.c iprb815worst.c linuxworst.c rfc815worst.c

IPFRAG_SRC_LIB := $(patsubst %,$(DIRIPFRAG)/%,$(IPFRAG_SRC_LIB))
IPFRAG_SRC := $(patsubst %,$(DIRIPFRAG)/%,$(IPFRAG_SRC))

IPFRAG_OBJ_LIB := $(patsubst %.c,%.o,$(IPFRAG_SRC_LIB))
IPFRAG_OBJ := $(patsubst %.c,%.o,$(IPFRAG_SRC))

IPFRAG_DEP_LIB := $(patsubst %.c,%.d,$(IPFRAG_SRC_LIB))
IPFRAG_DEP := $(patsubst %.c,%.d,$(IPFRAG_SRC))

CFLAGS_IPFRAG := -I$(DIRMISC) -I$(DIRIPHDR) -I$(DIRALLOC) -I$(DIRPACKET) -I$(DIRLINKEDLIST) -I$(DIRMYPCAP) -I$(DIRRBTREE)
LIBS_IPFRAG := $(DIRALLOC)/liballoc.a $(DIRIPHDR)/libiphdr.a $(DIRMYPCAP)/libmypcap.a $(DIRRBTREE)/librbtree.a

MAKEFILES_IPFRAG := $(DIRIPFRAG)/module.mk

.PHONY: IPFRAG clean_IPFRAG distclean_IPFRAG unit_IPFRAG $(LCIPFRAG) clean_$(LCIPFRAG) distclean_$(LCIPFRAG) unit_$(LCIPFRAG)

$(LCIPFRAG): IPFRAG
clean_$(LCIPFRAG): clean_IPFRAG
distclean_$(LCIPFRAG): distclean_IPFRAG
unit_$(LCIPFRAG): unit_IPFRAG

IPFRAG: $(DIRIPFRAG)/libipfrag.a $(DIRIPFRAG)/ipfragtest $(DIRIPFRAG)/ipreasstest $(DIRIPFRAG)/rfc815test $(DIRIPFRAG)/combotest $(DIRIPFRAG)/rfc815perf $(DIRIPFRAG)/ipreassperf $(DIRIPFRAG)/comboperf $(DIRIPFRAG)/linuxperf $(DIRIPFRAG)/rfc791test $(DIRIPFRAG)/rfc791perf $(DIRIPFRAG)/linuxtest $(DIRIPFRAG)/iprbexplicittest $(DIRIPFRAG)/iprbexplicitperf $(DIRIPFRAG)/ipreassworst $(DIRIPFRAG)/iprbexplicitworst $(DIRIPFRAG)/iprb815test $(DIRIPFRAG)/iprb815perf $(DIRIPFRAG)/iprb815worst $(DIRIPFRAG)/linuxworst $(DIRIPFRAG)/rfc815worst

unit_IPFRAG:
	@true

$(DIRIPFRAG)/libipfrag.a: $(IPFRAG_OBJ_LIB) $(MAKEFILES_COMMON) $(MAKEFILES_IPFRAG)
	rm -f $@
	ar rvs $@ $(filter %.o,$^)

$(DIRIPFRAG)/linuxtest: $(DIRIPFRAG)/linuxtest.o $(DIRIPFRAG)/libipfrag.a $(LIBS_IPFRAG) $(MAKEFILES_COMMON) $(MAKEFILES_IPFRAG)
	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(filter %.a,$^) $(CFLAGS_IPFRAG)

$(DIRIPFRAG)/linuxperf: $(DIRIPFRAG)/linuxperf.o $(DIRIPFRAG)/libipfrag.a $(LIBS_IPFRAG) $(MAKEFILES_COMMON) $(MAKEFILES_IPFRAG)
	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(filter %.a,$^) $(CFLAGS_IPFRAG)

$(DIRIPFRAG)/linuxworst: $(DIRIPFRAG)/linuxworst.o $(DIRIPFRAG)/libipfrag.a $(LIBS_IPFRAG) $(MAKEFILES_COMMON) $(MAKEFILES_IPFRAG)
	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(filter %.a,$^) $(CFLAGS_IPFRAG)

$(DIRIPFRAG)/ipfragtest: $(DIRIPFRAG)/ipfragtest.o $(DIRIPFRAG)/libipfrag.a $(LIBS_IPFRAG) $(MAKEFILES_COMMON) $(MAKEFILES_IPFRAG)
	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(filter %.a,$^) $(CFLAGS_IPFRAG)

$(DIRIPFRAG)/iprbexplicittest: $(DIRIPFRAG)/iprbexplicittest.o $(DIRIPFRAG)/libipfrag.a $(LIBS_IPFRAG) $(MAKEFILES_COMMON) $(MAKEFILES_IPFRAG)
	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(filter %.a,$^) $(CFLAGS_IPFRAG)

$(DIRIPFRAG)/iprbexplicitperf: $(DIRIPFRAG)/iprbexplicitperf.o $(DIRIPFRAG)/libipfrag.a $(LIBS_IPFRAG) $(MAKEFILES_COMMON) $(MAKEFILES_IPFRAG)
	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(filter %.a,$^) $(CFLAGS_IPFRAG)

$(DIRIPFRAG)/ipreasstest: $(DIRIPFRAG)/ipreasstest.o $(DIRIPFRAG)/libipfrag.a $(LIBS_IPFRAG) $(MAKEFILES_COMMON) $(MAKEFILES_IPFRAG)
	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(filter %.a,$^) $(CFLAGS_IPFRAG)

$(DIRIPFRAG)/rfc815test: $(DIRIPFRAG)/rfc815test.o $(DIRIPFRAG)/libipfrag.a $(LIBS_IPFRAG) $(MAKEFILES_COMMON) $(MAKEFILES_IPFRAG)
	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(filter %.a,$^) $(CFLAGS_IPFRAG)

$(DIRIPFRAG)/iprb815test: $(DIRIPFRAG)/iprb815test.o $(DIRIPFRAG)/libipfrag.a $(LIBS_IPFRAG) $(MAKEFILES_COMMON) $(MAKEFILES_IPFRAG)
	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(filter %.a,$^) $(CFLAGS_IPFRAG)

$(DIRIPFRAG)/iprb815perf: $(DIRIPFRAG)/iprb815perf.o $(DIRIPFRAG)/libipfrag.a $(LIBS_IPFRAG) $(MAKEFILES_COMMON) $(MAKEFILES_IPFRAG)
	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(filter %.a,$^) $(CFLAGS_IPFRAG)

$(DIRIPFRAG)/iprb815worst: $(DIRIPFRAG)/iprb815worst.o $(DIRIPFRAG)/libipfrag.a $(LIBS_IPFRAG) $(MAKEFILES_COMMON) $(MAKEFILES_IPFRAG)
	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(filter %.a,$^) $(CFLAGS_IPFRAG)

$(DIRIPFRAG)/rfc815worst: $(DIRIPFRAG)/rfc815worst.o $(DIRIPFRAG)/libipfrag.a $(LIBS_IPFRAG) $(MAKEFILES_COMMON) $(MAKEFILES_IPFRAG)
	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(filter %.a,$^) $(CFLAGS_IPFRAG)

$(DIRIPFRAG)/rfc791test: $(DIRIPFRAG)/rfc791test.o $(DIRIPFRAG)/libipfrag.a $(LIBS_IPFRAG) $(MAKEFILES_COMMON) $(MAKEFILES_IPFRAG)
	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(filter %.a,$^) $(CFLAGS_IPFRAG)

$(DIRIPFRAG)/rfc815perf: $(DIRIPFRAG)/rfc815perf.o $(DIRIPFRAG)/libipfrag.a $(LIBS_IPFRAG) $(MAKEFILES_COMMON) $(MAKEFILES_IPFRAG)
	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(filter %.a,$^) $(CFLAGS_IPFRAG)

$(DIRIPFRAG)/rfc791perf: $(DIRIPFRAG)/rfc791perf.o $(DIRIPFRAG)/libipfrag.a $(LIBS_IPFRAG) $(MAKEFILES_COMMON) $(MAKEFILES_IPFRAG)
	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(filter %.a,$^) $(CFLAGS_IPFRAG)

$(DIRIPFRAG)/ipreassperf: $(DIRIPFRAG)/ipreassperf.o $(DIRIPFRAG)/libipfrag.a $(LIBS_IPFRAG) $(MAKEFILES_COMMON) $(MAKEFILES_IPFRAG)
	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(filter %.a,$^) $(CFLAGS_IPFRAG)

$(DIRIPFRAG)/ipreassworst: $(DIRIPFRAG)/ipreassworst.o $(DIRIPFRAG)/libipfrag.a $(LIBS_IPFRAG) $(MAKEFILES_COMMON) $(MAKEFILES_IPFRAG)
	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(filter %.a,$^) $(CFLAGS_IPFRAG)

$(DIRIPFRAG)/iprbexplicitworst: $(DIRIPFRAG)/iprbexplicitworst.o $(DIRIPFRAG)/libipfrag.a $(LIBS_IPFRAG) $(MAKEFILES_COMMON) $(MAKEFILES_IPFRAG)
	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(filter %.a,$^) $(CFLAGS_IPFRAG)

$(DIRIPFRAG)/comboperf: $(DIRIPFRAG)/comboperf.o $(DIRIPFRAG)/libipfrag.a $(LIBS_IPFRAG) $(MAKEFILES_COMMON) $(MAKEFILES_IPFRAG)
	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(filter %.a,$^) $(CFLAGS_IPFRAG)

$(DIRIPFRAG)/combotest: $(DIRIPFRAG)/combotest.o $(DIRIPFRAG)/libipfrag.a $(LIBS_IPFRAG) $(MAKEFILES_COMMON) $(MAKEFILES_IPFRAG)
	$(CC) $(CFLAGS) -o $@ $(filter %.o,$^) $(filter %.a,$^) $(CFLAGS_IPFRAG)

$(IPFRAG_OBJ): %.o: %.c %.d $(MAKEFILES_COMMON) $(MAKEFILES_IPFRAG)
	$(CC) $(CFLAGS) -c -o $*.o $*.c $(CFLAGS_IPFRAG)
	$(CC) $(CFLAGS) -c -S -o $*.s $*.c $(CFLAGS_IPFRAG)

$(IPFRAG_DEP): %.d: %.c $(MAKEFILES_COMMON) $(MAKEFILES_IPFRAG)
	$(CC) $(CFLAGS) -MM -MP -MT "$*.d $*.o" -o $*.d $*.c $(CFLAGS_IPFRAG)

clean_IPFRAG:
	rm -f $(IPFRAG_OBJ) $(IPFRAG_DEP)

distclean_IPFRAG: clean_IPFRAG
	rm -f $(DIRIPFRAG)/libipfrag.a $(DIRIPFRAG)/ipfragtest $(DIRIPFRAG)/ipreasstest

-include $(DIRIPFRAG)/*.d
