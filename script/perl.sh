#!/bin/bash -eux

echo "==> Install cpanm"
curl -L http://cpanmin.us | perl - --sudo App::cpanminus
ln -s /usr/local/bin/cpanm /usr/bin/.

echo "==> Install prerequisite perl modules"
cpanm -n Thread::Queue

echo "==> Install perl modules"
cpanm -n CGI::Ajax CGI::Expand CGI::Session Data::Compare Data::Validate Date::Calc Date::Manip DateTime::Format::DateParse FindBin::libs Geo::Calc::XS Geo::Coordinates::ITM Geo::HelmertTransform JSON Math::Polygon::Calc Math::Round MongoDB Mojolicious Net::Telnet Perl::Tidy@20140328 Proc::Background Selenium::Remote::Driver SOAP::Lite Text::CSV Text::CSV_XS XML::Compare XML::Filter::Sort XML::Hash XML::LibXML::Iterator XML::LibXSLT XML::SAX::Machines XML::Tidy XML::XML2JSON
