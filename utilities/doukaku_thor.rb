#!/usr/bin/env ruby
# coding: utf-8

# 使い方は以下の出力を参照
# ./hoge.rb list
#
# pitで以下の設定をする必要あり
# work:
#   github:
#     login: ユーザ名 ex: keqh
#     oauth_token: API叩いて取得
#   pivotal:
#     api_token: https://www.pivotaltracker.com/profile の一番下にある
#     username: pivotalで表示される名前 ex: keqh
#     project_id: urlの'projects/XXXXXX'のXXXXXX部分

require 'thor'
require 'thor/runner'
require 'awesome_print' # for debug

require 'mechanize'

def config
  Pit.get('work')
end

def format_test_data(input, output)
  <<"EOS"
("#{input}","#{output}")
EOS
end

def get_test_data(url)
  agent = Mechanize.new
  page = agent.get url
  #最後のtableがtestであることを期待している
  test_table = (page / 'table')[-1]
  testdata = (test_table / 'tr')[1..-1].map { |node|
    (node / 'code').map(&:text)
  }

  data = testdata.map {|i,o| format_test_data(i,o)}.join("    ,")
  <<"EOL"
module TestData(t) where
t = [#{data}
    ]
EOL
end

# COMMANDS
# ==============================================================================

PROJECT_DIR = "/Users/keqh/projects/_workshops/doukaku/"

class Work < Thor
  include Thor::Actions

  desc 'init', 'init'
  def init(url)
    invoke "work:init_project", []
    invoke "work:set_testdata", [url]
    `open -a 'google chrome' #{url}`
  end

  desc 'init_project', 'init_project'
  def init_project
    date = Time.now.strftime('%Y%m%d')
    dir = "doukaku_" + date
    inside(PROJECT_DIR) do
      `cp -R doukaku-template-haskell #{dir}`
    end
    inside(PROJECT_DIR + dir) do
      `tmux split-window -p70 "./watch.sh cat spec.txt"`
      `subl3 Main.hs`
    end
  end

  desc 'set_testdata', 'setup set_testdata'
  def set_testdata(url)
    date = Time.now.strftime('%Y%m%d')
    dir = "doukaku_" + date
    inside(PROJECT_DIR + dir) do
      File.write 'TestData.hs', get_test_data(url)
    end
  end

  desc 'testdata', 'dump testdata'
  def testdata(url)
    puts get_test_data(url)
  end
end

# execとして使うときにnamespaceを有効にする場合はこの変数をtrueにする必要がある
# see: https://github.com/wycats/thor/issues/249
$thor_runner = true
Thor::Runner.start(ARGV)
