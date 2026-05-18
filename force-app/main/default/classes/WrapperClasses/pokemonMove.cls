public class pokemonMove {

public class VersionGroupDetail {
        public Integer level_learned_at;
        public MoveInfo move_learn_method;
        public MoveInfo version_group;
    }

    public class MoveData {
        public MoveInfo move;
        public List<VersionGroupDetail> version_group_details;
    }

    public class MoveInfo {
        public String name;
        public String url;
    }

    // Variables on the main wrapper
    public List<MoveData> moves;
    public String name;
}