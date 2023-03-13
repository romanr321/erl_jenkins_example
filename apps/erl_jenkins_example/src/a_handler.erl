-module(a_handler).
-behaviour(cowboy_handler).
-export([init/2]).

init( Req, Ops) ->
    {ok, cowboy_req:reply(204, Req), Ops}.
