#!/bin/sh
rebar get-deps && rebar compile && \
exec erl -pa $PWD/ebin $PWD/deps/*/ebin -boot start_sasl -config sys.config -s wstest_app
