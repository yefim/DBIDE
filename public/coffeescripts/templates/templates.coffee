DBIDE.Templates.Main = '''
  <h5>Folders</h5> <img class="new-folder" style="vertical-align:-1px;" src="/images/plus.png">
  <hr class='small' />
  <div class='root'></div>
'''

DBIDE.Templates.File = '''
  <li class='file'><%= path.display_name() %></li>
'''

DBIDE.Templates.CreateFile = '''
  <li class='create'><input type="text" class="new-file-name" placeholder="name"></li>
'''

DBIDE.Templates.Files = '''
  <li><span class='folder'><%= path.display_name() %></span> <img class="new-file" style="vertical-align:-1px;" src="/images/plus.png"></li>
  <ul class='files'></ul>
'''
