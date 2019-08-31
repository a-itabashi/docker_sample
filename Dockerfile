FROM ruby:2.5.1

# リポジトリを更新し依存モジュールをインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       nodejs

# ルート直下にwebappという名前で作業ディレクトリを作成（コンテナ内のアプリケーションディレクトリ）
RUN mkdir /app
WORKDIR /app

# ホストのGemfileとGemfile.lockをコンテナにコピー
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock

# bundle installの実行
RUN bundle install

# ホストのアプリケーションディレクトリ内をすべてコンテナにコピー
ADD . /app

# puma.sockを配置するディレクトリを作成
RUN mkdir -p tmp/sockets