# A sample Guardfile
# More info at https://github.com/guard/guard#readme
guard :minitest, spring: 'rake test' do
  # with Minitest::Unit
  watch(%r{^test/(.*)\/(.*)\.rb})
  watch(%r{^test/integration/.+_test\.rb})
  watch(%r{^test/models/.+_test\.rb})
  watch(%r{^test/contollers/.+_test\.rb})
  watch(%r{^test/helpers/.+_test\.rb})
  watch(%r{^test/mailers/.+_test\.rb})
  watch(%r{^lib/(.*/)?([^/]+)\.rb})     { |m| "test/#{m[1]}test_#{m[2]}.rb" }
  watch(%r{^test/test_helper\.rb})      { 'test' }

  # Rails 4
  watch(%r{^test/test_helper\.rb}) { 'test' }
  watch(%r{^test/.+_test\.rb})
  watch(%r{^test/integration/.+_test\.rb})
  watch(%r{^test/models/.+_test\.rb})
  watch(%r{^test/contollers/.+_test\.rb})
  watch(%r{^test/helpers/.+_test\.rb})
  watch(%r{^test/mailers/.+_test\.rb})
  watch(%r{^app/(.+)\.rb})                               { |m| "test/#{m[1]}_test.rb" }
  watch(%r{^app/controllers/application_controller\.rb}) { 'test/controllers' }
  watch(%r{^app/controllers/(.+)_controller\.rb})        { |m| "test/integration/#{m[1]}_test.rb" }
  watch(%r{^app/views/(.+)_mailer/.+})                   { |m| "test/mailers/#{m[1]}_mailer_test.rb" }
  watch(%r{^lib/(.+)\.rb})                               { |m| "test/lib/#{m[1]}_test.rb" }
end
