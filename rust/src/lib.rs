mod bridge_generated; /* AUTO INJECTED BY flutter_rust_bridge. This line may not be accurate, and you can change it according to your needs. */
mod api;


#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn it_works() {
        let res = api::get_name();
        println!("The name is {}", res);
    }
}
