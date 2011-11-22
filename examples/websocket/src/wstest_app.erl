-module(wstest_app).

-behaviour(application).

-export([start/0]).

%% Application callbacks
-export([start/2, stop/1]).

start() -> application:start(wstest).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    wstest_sup:start_link().

stop(_State) ->
    ok.
