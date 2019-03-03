require 'spec_helper'

describe ActiveRecord::PreloadBlock do
  before do
    4.times.each do
      user = User.create
      2.times { user.comments.create }
      2.times { user.posts.create }
    end
  end

  context '#preload without block' do
    it 'should be normal' do
      users = User.all.preload(:comments)

      expect(users.all? { |u| u.comments.loaded? }).to eq(true)
    end

    context 'and argument' do
      it 'should raise ArgumentError' do
        expect { User.all.preload }.to raise_error(ArgumentError, 'The method .preload() must contain arguments.')
      end
    end
  end

  context '#preload with block' do
    it 'should be preloaded' do
      users = User.all.preload do |records|
        preload records.select(&:odd_id?), :comments
      end

      expect(users.select(&:odd_id?).all? { |u| u.comments.loaded? }).to eq(true)
      expect(users.select(&:even_id?).all? { |u| !u.comments.loaded? }).to eq(true)
    end

    context 'and preload_scope' do
      it 'should be preloaded' do
        user_odd_ids = User.all.select(&:odd_id?).map(&:id)
        odd_id_users_comment_ids = Comment.where(user_id: user_odd_ids).ids

        users = User.all.preload do |records|
          preload records, :comments, Comment.where(id: odd_id_users_comment_ids)
        end

        expect(users.select(&:odd_id?).all? { |u| u.comments.loaded? }).to eq(true)
        expect(users.select(&:even_id?).all? { |u| u.comments.loaded? }).to eq(true)
      end
    end
  end

  context '#preload with multi preload in a block' do
    it 'should be preloaded' do
      users = User.all.preload do |records|
        preload records.select(&:odd_id?), :comments
        preload records.select(&:even_id?), :posts
      end

      expect(users.select(&:odd_id?).all? { |u| u.comments.loaded? }).to eq(true)
      expect(users.select(&:even_id?).all? { |u| !u.comments.loaded? }).to eq(true)
      expect(users.select(&:odd_id?).all? { |u| !u.posts.loaded? }).to eq(true)
      expect(users.select(&:even_id?).all? { |u| u.posts.loaded? }).to eq(true)
    end

    context 'and arguments' do
      it 'should be preloaded' do
        users = User.all.preload(:posts) do |records|
          preload records.select(&:odd_id?), :comments
        end

        expect(users.select(&:odd_id?).all? { |u| u.comments.loaded? }).to eq(true)
        expect(users.select(&:even_id?).all? { |u| !u.comments.loaded? }).to eq(true)
        expect(users.all? { |u| u.posts.loaded? }).to eq(true)
      end
    end

    context 'and method chain' do
      it 'should be preloaded' do
        users = User.all.preload { |records|
          preload records.select(&:odd_id?), :comments
          preload records.select(&:even_id?), :posts
        }.limit(3)

        expect(users.select(&:odd_id?).all? { |u| u.comments.loaded? }).to eq(true)
        expect(users.select(&:even_id?).all? { |u| !u.comments.loaded? }).to eq(true)
        expect(users.select(&:odd_id?).all? { |u| !u.posts.loaded? }).to eq(true)
        expect(users.select(&:even_id?).all? { |u| u.posts.loaded? }).to eq(true)
      end
    end
  end
end
