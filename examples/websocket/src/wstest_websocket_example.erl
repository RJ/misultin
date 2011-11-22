-module(wstest_websocket_example).
-export([start_link/0, start_link/1, stop/0]).

start_link() -> start_link(3333).

start_link(Port) ->
    misultin:start_link([
            {port, Port}, 
            {loop, fun(Req) -> handle_http(Req, Port) end}, 
            {ws_loop, fun(Ws) -> handle_websocket(Ws) end}
        ]).

stop() ->
    misultin:stop().

handle_http(Req, Port) ->	
    Path = case element(2,Req:get(uri)) of "/" -> "/index.html" ; P -> P end,
    case file:read_file( "./priv" ++ Path ) of
        {ok, Bin} -> Req:ok([{"Content-Type", "text/html"}], [Bin]);
        _         -> Req:not_found()
    end.

handle_websocket(Ws) ->
    receive
        {browser, Data} ->
            Ws:send(["received '", Data, "'"]),
            handle_websocket(Ws);
        _Ignore ->
            handle_websocket(Ws)
    after 5000 ->
            Ws:send("pushing!"),
            handle_websocket(Ws)
    end.
