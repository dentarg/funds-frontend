require 'sinatra'
require 'sinatra/reloader' if development?
require 'uri'
require 'redis'
require 'haml'

enable :inline_templates

R = Redis.new

get '/' do
  @documents = R.keys('*')
  haml :list
end

get '/:doc' do
  R.get params['doc']
end

__END__

@@ layout
%html
  %head
    %title funds
  %body
    = yield

@@ list
%h1 documents
%ul
  -@documents.each do |doc|
    %li
      %a{ href: doc }= doc
