DBIDE.Templates.Main = '''
  <h5>Projects <img class="new-folder pull-right" style="vertical-align:-1px;" src="/images/plus.png"></h5>
  <hr class='small' />
  <ul class='root'></ul>
'''

DBIDE.Templates.File = '''
  <li class='file <%= window.current_file.get("path") === path ? "selected" : "" %>'><%= path.display_name() %></li>
'''

DBIDE.Templates.CreateFile = '''
  <li class='create'><input type="text" class="new-file-name" placeholder="Enter to Save"></li>
'''

DBIDE.Templates.Files = '''
  <li class='folder'><img src='<%= expanded ? "open" : "closde %>'><%= path.display_name() %> <img class="new-file pull-right" style="vertical-align:-1px;" src="/images/plus.png"></li>
  <ul class='files'></ul>
'''
