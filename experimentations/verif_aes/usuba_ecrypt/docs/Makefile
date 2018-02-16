estream-howto.html: estream-howto.xml
	xsltproc /usr/share/xml/docbook/stylesheet/ldp/html/tldp-one-page.xsl \
	$< > $@

README: estream-howto.html 
	links -dump -no-references -no-numbering $< > $@