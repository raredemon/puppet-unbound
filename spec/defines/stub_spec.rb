# frozen_string_literal: true

require 'spec_helper'

describe 'unbound::stub' do
  let(:title) { 'lab.example.com' }

  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

      context 'basic' do
        let(:params) do
          {
            address: ['::1']
          }
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_unbound__stub('lab.example.com') }

        it {
          expect(subject).to contain_concat__fragment('unbound-stub-lab.example.com').with(
            content: <<~ZONE
              stub-zone:
                name: "lab.example.com"
                stub-addr: ::1
            ZONE
          )
        }
      end

      context 'with no_cache set' do
        let(:params) do
          {
            address: ['::1'],
            no_cache: true
          }
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_unbound__stub('lab.example.com') }

        it {
          expect(subject).to contain_concat__fragment('unbound-stub-lab.example.com').with(
            content: <<~ZONE
              stub-zone:
                name: "lab.example.com"
                stub-addr: ::1
                stub-no-cache: yes
            ZONE
          )
        }
      end

      context 'with address set as string' do
        let(:params) do
          {
            address: '::1',
            no_cache: true
          }
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_unbound__stub('lab.example.com') }

        it {
          expect(subject).to contain_concat__fragment('unbound-stub-lab.example.com').with(
            content: <<~ZONE
              stub-zone:
                name: "lab.example.com"
                stub-addr: ::1
                stub-no-cache: yes
            ZONE
          )
        }
      end
    end
  end
end
