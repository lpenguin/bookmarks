require "./models"
class FolderHelper
	def self.get_folder_by_name(name)
		folder = Folder.first :name => name
		if folder == nil
			folder = Folder.new(
				:name => name
				)
		end
		return folder
	end

	def self.get_folder_by_path(path)
		root = get_root_folder
		parent = root
		folder = nil
		names = path.split '.'
		names.each do |name|
			folder = search_folder parent, name
			if folder == nil 
				folder = create_folder parent, name
			end
			parent = folder
		end
		return folder
	end

	def self.search_folder(parent, name)
		parent.attachments.each do |attachment|
			if attachment.name == name and attachment.type == 'Folder'
				return attachment
			end
		end
		return nil
	end

	def self.create_folder(parent, name)
		folder = Folder.create(
			:name => name
			)
		parent.attachments << folder
		parent.save
		return folder
	end

	def self.get_root_folder()
		root = Folder.find_by :root => true
        puts "root is #{root}"
		if root == nil
			root = Folder.create(
				:name => 'root',
				:root => true
				)
		end
		return root
	end

	def self.folder_filter(node)
		children = []
		node.attachments.each do |att|
			if att['type'] == 'Folder'
				children.push node_rec(att, only_folders)
			end
		end
		res = {
			:name => node['name'],
			:children => children
		}
		return res		
	end
end
