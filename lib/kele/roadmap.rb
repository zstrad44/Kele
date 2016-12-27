module Roadmap

  def get_roadmap(roadmap_id)

    receive = self.class.get(@api_url + '/roadmaps/' + roadmap_id.to_s, headers: { "authorization" => @auth_token })

    JSON.parse(receive.body)

  end

  def get_checkpoint(checkpoint_id)

    receive = self.class.get(@api_url + '/checkpoints/' + checkpoint_id.to_s, headers: { "authorization" => @auth_token })

    JSON.parse(receive.body)

  end

end
