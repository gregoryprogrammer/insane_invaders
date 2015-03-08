FCSHC=$(shell which fcshc)
MXMLC=$(FCSHC) mxmlc
OPTIONS=-static-link-runtime-shared-libraries=true
SRC=src/InsaneInvaders.as
SWF=build/insane_invaders.swf

$(SWF):
		$(MXMLC) -sp $(OPTIONS) $(SRC) -o $(SWF)

run: $(SWF)
		flashplayerdebugger $(SWF)

clean:
	rm $(SWF)

