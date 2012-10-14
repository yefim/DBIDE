DBIDE.Templates.Main = '''
  <h5>Projects <img class="new-folder pull-right" style="vertical-align:-1px;" src="/images/plus.png"></h5>
  <hr class='small' />
  <div class='root'></div>
'''

DBIDE.Templates.File = '''
  <li class='file'><%= path.display_name() %></li>
'''

DBIDE.Templates.CreateFile = '''
  <li class='create'><input type="text" class="new-file-name" placeholder="Enter to Save"></li>
'''

DBIDE.Templates.Files = '''
  <li><span class='folder'><%= path.display_name() %></span> <img class="new-file pull-right" style="vertical-align:-1px;" src="/images/plus.png"></li>
  <ul class='files'></ul>
'''
